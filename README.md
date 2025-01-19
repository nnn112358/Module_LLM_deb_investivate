# Module_LLM_deb_investivate

M5StackのModuleLLMのdebパッケージから情報を抽出しました。<br>
<https://github.com/nnn112358/Module_LLM_deb_investivate/blob/main/deb_analysis_20250108_090239.txt><br>

https://docs.m5stack.com/en/guide/llm/llm/image<br>
(2025/1/7)
```
lib-llm_1.4-m5stack1_arm64.deb
llm-depth-anything_1.3-m5stack1_arm64.deb
llm-internvl2.5-1B-ax630c_0.3-m5stack1_arm64.deb
llm-llama3.2-1B-prefill-ax630c_0.2-m5stack1_arm64.deb
llm-llm_1.4-m5stack1_arm64.deb
llm-melotts_1.4-m5stack1_arm64.deb
llm-openbuddy-llama3.2-1B-ax630c_0.2-m5stack1_arm64.deb
llm-qwen2.5-1.5B-ax630c_0.3-m5stack1_arm64.deb
llm-qwen2.5-coder-0.5B-ax630c_0.2-m5stack1_arm64.deb
llm-sherpa-onnx-kws-zipformer-gigaspeech-3.3M-2024-01-01_0.3-m5stack1_arm64.deb
llm-sherpa-onnx-kws-zipformer-wenetspeech-3.3M-2024-01-01_0.3-m5stack1_arm64.deb
llm-vlm_1.4-m5stack1_arm64.deb
llm-yolo11n-hand-pose_0.3-m5stack1_arm64.deb
llm-yolo11n-pose_0.3-m5stack1_arm64.deb
llm-yolo_1.4-m5stack1_arm64.deb
```

```
debパッケージから以下の情報を取得しました。


1. 基本情報 (`dpkg-deb -I`)
   - パッケージ名、バージョン
   - メンテナ情報
   - 説明文

2. コントロール情報
   - コントロールファイルの内容
   - インストール前後のスクリプト
   - 削除前後のスクリプト
   - 設定スクリプト

3. アーキテクチャ情報

4. MD5チェックサム
   - パッケージの整合性確認用

5. ファイル一覧 (`dpkg -c`)
   - 含まれるファイルとパーミッション

6. パッケージサイズ
   - ファイルサイズと更新日時

7. 依存関係
   - 必須依存（Depends）
   - 事前依存（Pre-Depends）
   - 推奨パッケージ（Recommends）
   - 提案パッケージ（Suggests）

使い方は：
```bash
chmod +x deb-contents.sh
./deb-contents.sh [ディレクトリパス]
```

