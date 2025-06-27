🚀 React + Vite プロジェクト自動作成スクリプト
🔥 概要
このスクリプトは、PowerShellを使って
React + Viteのプロジェクトを簡単に作成する自動化ツールです。

✅ プロジェクト名を入力するだけで、以下の作業を自動化します。

フォルダ選択

サブフォルダの作成（プロジェクト名）

Vite + React テンプレートのセットアップ

npm install による依存関係のインストール

Visual Studio Code（VSCode）の自動起動

📦 必要な環境
Node.js（npmが使える状態）

PowerShell 5 以上（Windows標準搭載）

Visual Studio Code（code コマンドが使えるようにしておく）

⚙️ インストール方法
このスクリプトファイル（例: Create-ReactVite.ps1）を任意のフォルダに保存。

PowerShellでスクリプトの実行を許可する必要があります。

実行許可が出ない場合は、管理者権限でPowerShellを開いて以下を実行：

powershell
コピーする
編集する
Set-ExecutionPolicy RemoteSigned
🚀 使い方
1️⃣ スクリプトを実行
PowerShellでスクリプトがあるフォルダに移動して実行：

powershell
コピーする
編集する
.\Create-ReactVite.ps1
2️⃣ 実行フロー
✅ プロジェクト名を入力

✅ フォルダ選択ダイアログが表示される

✅ 指定したフォルダの中に「プロジェクト名」のサブフォルダが作成される

✅ 自動でVite + Reactのテンプレートがセットアップされる

✅ 依存関係 (npm install) が自動でインストールされる

✅ VSCodeが自動で起動

📂 フォルダ構成
lua
コピーする
編集する
(選んだフォルダ)/
└── (プロジェクト名)/
    ├── package.json
    ├── vite.config.js
    ├── index.html
    ├── node_modules/
    └── src/
❗ エラーが出る場合
Node.jsがインストールされていない
→ Node.js公式サイトからインストール

code コマンドが使えない
→ VSCodeの「コマンドパレット（Ctrl+Shift+P）」で「Shell Command: Install 'code' command in PATH」を実行

実行ポリシーのエラー
→ PowerShellを管理者で開き、以下を実行

powershell
コピーする
編集する
Set-ExecutionPolicy RemoteSigned
💡 補足・カスタマイズ案
テンプレートをReact以外（Vue, Svelte, Vanilla）に変更可能

npm run dev の自動起動も追加可能

Zipファイル化やGit初期化も対応可能

👉 必要ならすぐにカスタマイズ対応可能🔥

