param(
    [string]$ExistingPath
)

Add-Type -AssemblyName System.Windows.Forms

# Node.jsの存在チェック
function Check-Node {
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Output "❌ Node.js (npm) が見つかりません。公式サイトからインストールしてください。"
        Start-Process "https://nodejs.org/"
        exit
    }
}

# VSCodeの起動
function Start-VSCode {
    if (Get-Command code -ErrorAction SilentlyContinue) {
        Write-Output "🖥️ VSCode を起動します..."
        code .
    } else {
        Write-Output "⚠️ VSCode のコマンドが見つかりません。手動でフォルダを開いてください。"
    }
}

# package.json が無ければ作成
function Check-Or-Create-PackageJson {
    param(
        [string]$path
    )
    $packageFile = Join-Path $path "package.json"
    if (-not (Test-Path $packageFile)) {
        Write-Output "⚠️ package.json が存在しません。新しく作成します..."
        Set-Location -Path $path
        npm init -y

        if (!$?) {
            Write-Output "❌ package.json の作成に失敗しました。"
            exit
        }

        Write-Output "✅ package.json を作成しました。"
    } else {
        Write-Output "✅ package.json が存在します。"
    }
}

# 既存フォルダへのnpm install
function Install-ExistingProject {
    param(
        [string]$path
    )

    if (-not (Test-Path $path)) {
        Write-Output "❌ 指定されたパスが存在しません: $path"
        exit
    }

    Write-Output "📁 ターゲットフォルダ: $path"

    # Viteの構成が存在するか確認
    $indexFile = Join-Path $path "index.html"
    if (-not (Test-Path $indexFile)) {
        Write-Output "⚠️ Vite プロジェクトの構成が見つかりません。テンプレートを展開します..."

        Set-Location -Path $path
        npm create vite@latest . -- --template react

        if (!$?) {
            Write-Output "❌ Vite プロジェクトの作成に失敗しました。"
            exit
        }
    } else {
        Write-Output "✅ Vite のプロジェクト構成が存在します。"
    }

    Check-Or-Create-PackageJson -path $path

    Set-Location -Path $path

    Write-Output "📦 npm install を実行中..."
    npm install

    if (!$?) {
        Write-Output "❌ npm install に失敗しました。"
        exit
    }

    Start-VSCode
}



# 新規プロジェクトの作成
function Start-ViteProject {
    # プロジェクト名を入力
    $projectName = Read-Host "プロジェクト名を入力してください"
    if ([string]::IsNullOrWhiteSpace($projectName)) {
        Write-Output "⚠️ プロジェクト名が入力されていません。終了します。"
        exit
    }

    # フォルダ選択ダイアログ
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "プロジェクトを作成するフォルダを選んでください"

    if ($dialog.ShowDialog() -ne "OK") {
        Write-Output "⚠️ フォルダが選択されていません。終了します。"
        exit
    }

    $targetDir = $dialog.SelectedPath
    Write-Output "✅ 選択されたフォルダ: $targetDir"

    # サブフォルダ（プロジェクト用）を作成
    $projectPath = Join-Path $targetDir $projectName

    if (Test-Path $projectPath) {
        Write-Output "⚠️ 同じ名前のフォルダが既に存在します。終了します。"
        exit
    }

    New-Item -ItemType Directory -Path $projectPath | Out-Null
    Write-Output "📁 サブフォルダ作成: $projectPath"

    # Viteプロジェクト作成
    Set-Location -Path $projectPath

    Write-Output "🚀 Vite プロジェクトのテンプレートを作成中..."
    npm create vite@latest . -- --template react

    if (!$?) {
        Write-Output "❌ Vite プロジェクトの作成に失敗しました。"
        exit
    }

    # 依存関係インストール
    Write-Output "📦 npm install を実行中..."
    npm install

    if (!$?) {
        Write-Output "❌ npm install に失敗しました。"
        exit
    }

    # VSCodeで開く
    Write-Output "🖥️ VSCode を起動します..."
    code .

    Write-Output "✅ プロジェクトが作成されました！フォルダ: $projectPath"
}



# ---------- メイン ----------
Check-Node

if ($ExistingPath) {
    Install-ExistingProject -path $ExistingPath
} else {
    Start-ViteProject
}

Write-Output "🎉 完了しました！"
