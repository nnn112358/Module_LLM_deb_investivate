#!/bin/bash

# スクリプトの使用方法を表示する関数
show_usage() {
    echo "使用方法: $0 [ディレクトリパス]"
    echo "指定されたディレクトリ内のすべての.debファイルの詳細情報を表示し、結果をテキストファイルに保存します"
    echo "ディレクトリパスが指定されていない場合は、カレントディレクトリを使用します"
}

# 引数チェック
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_usage
    exit 0
fi

# ディレクトリパスの設定
DIR_PATH="${1:-.}"

# ディレクトリの存在確認
if [ ! -d "$DIR_PATH" ]; then
    echo "エラー: ディレクトリ '$DIR_PATH' が存在しません"
    exit 1
fi

# 出力ファイル名の設定
OUTPUT_FILE="deb_analysis_$(date '+%Y%m%d_%H%M%S').txt"

# 結果をファイルに保存する関数
save_header() {
    {
        echo "Debian パッケージ分析レポート"
        echo "実行日時: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "分析対象ディレクトリ: $DIR_PATH"
        echo "================================================"
        echo
    } > "$OUTPUT_FILE"
}

# パッケージの詳細情報を取得する関数
analyze_package() {
    local deb_file="$1"
    {
        echo "### パッケージ: $deb_file ###"
        echo
        
        echo "1. 基本情報 (dpkg-deb -I)"
        echo "------------------------"
        dpkg-deb -I "$deb_file"
        echo
        
        echo "2. コントロール情報 (dpkg -e)"
        echo "------------------------"
        # 一時ディレクトリの作成
        temp_dir=$(mktemp -d)
        dpkg-deb -e "$deb_file" "$temp_dir"
        
        # コントロールファイルの確認
        if [ -f "$temp_dir/control" ]; then
            cat "$temp_dir/control"
        fi
        
        # 各種スクリプトの確認
        for script in preinst postinst prerm postrm config; do
            if [ -f "$temp_dir/$script" ]; then
                echo
                echo "[$script スクリプト]"
                cat "$temp_dir/$script"
            fi
        done
        
        # 一時ディレクトリの削除
        rm -rf "$temp_dir"
        echo
        
        echo "3. アーキテクチャ情報 (dpkg-deb --field)"
        echo "------------------------"
        dpkg-deb --field "$deb_file" Architecture
        echo
        
        echo "4. MD5チェックサム"
        echo "------------------------"
        md5sum "$deb_file"
        echo
        
        echo "5. ファイル一覧 (dpkg -c)"
        echo "------------------------"
        dpkg -c "$deb_file"
        echo
        
        echo "6. パッケージサイズ"
        echo "------------------------"
        ls -lh "$deb_file"
        echo
        
        echo "7. 依存関係 (dpkg-deb --field)"
        echo "------------------------"
        dpkg-deb --field "$deb_file" Depends
        dpkg-deb --field "$deb_file" Pre-Depends
        dpkg-deb --field "$deb_file" Recommends
        dpkg-deb --field "$deb_file" Suggests
        echo
        
        echo "================================================"
        echo
    } | tee -a "$OUTPUT_FILE"
}

# メイン処理
save_header
found=0

echo "ディレクトリ '$DIR_PATH' 内の.debファイルを分析中..."

for deb_file in "$DIR_PATH"/*.deb; do
    if [ -f "$deb_file" ]; then
        analyze_package "$deb_file"
        ((found++))
    fi
done

# 結果のサマリー
{
    echo "サマリー"
    echo "--------"
    echo "処理完了時刻: $(date '+%Y-%m-%d %H:%M:%S')"
    if [ $found -eq 0 ]; then
        echo "警告: .debファイルが見つかりませんでした"
    else
        echo "処理したファイル数: $found"
    fi
} | tee -a "$OUTPUT_FILE"

# 完了メッセージ
if [ $found -eq 0 ]; then
    echo "結果は $OUTPUT_FILE に保存されましたが、.debファイルは見つかりませんでした"
    exit 1
else
    echo "詳細な分析結果が $OUTPUT_FILE に保存されました"
fi