# 大地工業電子名片 - 一鍵新增同事腳本 (PowerShell 版)
# 使用方式：powershell -ExecutionPolicy Bypass -File add-member.ps1

# 設置字符編碼
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 清除屏幕
Clear-Host

# 顏色輸出函數
function Write-Color {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

Write-Color "════════════════════════════════════════════════════════════════" -Color Blue
Write-Color "     🌟 大地工業電子名片系統 - 新增同事" -Color Blue
Write-Color "════════════════════════════════════════════════════════════════" -Color Blue
Write-Host ""

# 檢查必要檔案
Write-Color "📋 檢查系統環境..." -Color Yellow

$requiredFiles = @("TEMPLATE.html", "employees.csv", "logo.svg")
$allFilesExist = $true

foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Color "❌ 錯誤：找不到 $file" -Color Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    exit 1
}

Write-Color "✓ 檔案檢查完成" -Color Green
Write-Host ""

# 獲取用戶輸入
Write-Color "請輸入同事資訊：" -Color Blue
Write-Host ""

$CHN_NAME = Read-Host "1. 中文名字"
$ENG_NAME = Read-Host "2. 英文名 (例: Xiaoming Wang)"
$JOB_TITLE = Read-Host "3. 職稱 (可空白，例: Sales Manager)"
$SERVICE_DESC = Read-Host "4. 專業服務 (例: 銷售與客戶關係管理)"
$EMAIL = Read-Host "5. 郵件 (例: xiaoming@goodcomer.com)"
$PHONE = Read-Host "6. 電話 (例: (03)490-2000)"
$FOLDER_NAME = Read-Host "7. 資料夾名稱 (推薦: x.wang)"

Write-Host ""

# 驗證輸入
if ([string]::IsNullOrWhiteSpace($CHN_NAME) -or
    [string]::IsNullOrWhiteSpace($ENG_NAME) -or
    [string]::IsNullOrWhiteSpace($SERVICE_DESC) -or
    [string]::IsNullOrWhiteSpace($EMAIL) -or
    [string]::IsNullOrWhiteSpace($PHONE) -or
    [string]::IsNullOrWhiteSpace($FOLDER_NAME)) {
    Write-Color "❌ 錯誤：必填欄位不能為空" -Color Red
    exit 1
}

# 生成網址
$WEB_URL = "https://DDchJason.github.io/business-card/team/$FOLDER_NAME/"

Write-Color "📝 即將建立以下資訊：" -Color Yellow
Write-Host "  名字: $CHN_NAME ($ENG_NAME)"
Write-Host "  職稱: $(if ($JOB_TITLE) { $JOB_TITLE } else { '(空白)' })"
Write-Host "  專業: $SERVICE_DESC"
Write-Host "  郵件: $EMAIL"
Write-Host "  電話: $PHONE"
Write-Host "  資料夾: $FOLDER_NAME"
Write-Host "  網址: $WEB_URL"
Write-Host ""

$confirm = Read-Host "確認無誤？(y/n)"

if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Color "⏹️ 已取消" -Color Yellow
    exit 1
}

Write-Host ""
Write-Color "⚙️ 處理中..." -Color Yellow
Write-Host ""

try {
    # Step 1: 更新 CSV
    Write-Color "[1/5] 更新 employees.csv..." -Color Blue

    # 檢查資料夾是否已存在
    if (Test-Path "team\$FOLDER_NAME") {
        Write-Color "⚠️ 資料夾已存在，將覆蓋舊的檔案" -Color Yellow
    }

    # 將新行添加到 CSV
    $CSV_LINE = "$CHN_NAME,$ENG_NAME,$JOB_TITLE,$SERVICE_DESC,$EMAIL,$PHONE,$FOLDER_NAME,$WEB_URL"

    # 檢查是否已在 CSV 中
    $csvContent = Get-Content "employees.csv" -Raw
    if ($csvContent -match "^$CHN_NAME,") {
        Write-Color "⚠️ 同事已存在於 CSV，正在更新..." -Color Yellow
        # 刪除舊記錄
        $newContent = @()
        foreach ($line in (Get-Content "employees.csv")) {
            if (-not $line.StartsWith($CHN_NAME + ",")) {
                $newContent += $line
            }
        }
        $newContent | Set-Content "employees.csv"
    }

    # 添加新行
    Add-Content "employees.csv" $CSV_LINE
    Write-Color "✓ CSV 已更新" -Color Green

    # Step 2: 建立資料夾
    Write-Color "[2/5] 建立資料夾 team\$FOLDER_NAME\..." -Color Blue
    New-Item -ItemType Directory -Force -Path "team\$FOLDER_NAME" | Out-Null
    Write-Color "✓ 資料夾已建立" -Color Green

    # Step 3: 複製並編輯模板
    Write-Color "[3/5] 複製並編輯模板..." -Color Blue

    # 複製 TEMPLATE.html
    Copy-Item "TEMPLATE.html" "team\$FOLDER_NAME\index.html" -Force

    # 讀取並編輯 HTML
    $htmlContent = Get-Content "team\$FOLDER_NAME\index.html" -Raw

    # 中文版本替換
    $htmlContent = $htmlContent -replace "【改：名字】<br>\(【改：English Name】\)", "$CHN_NAME<br>($ENG_NAME)"
    $htmlContent = $htmlContent -replace "【改：職稱】", $JOB_TITLE
    $htmlContent = $htmlContent -replace "【改：專業服務描述】", $SERVICE_DESC
    $htmlContent = $htmlContent -replace "【改：電話】", $PHONE
    $htmlContent = $htmlContent -replace "【改：郵件】", $EMAIL

    # 英文版本替換
    $engTitle = if ($JOB_TITLE) { $JOB_TITLE } else { "Professional" }
    $htmlContent = $htmlContent -replace "【改：English Name】<br>\(【改：Nickname】\)", "$ENG_NAME<br>($ENG_NAME)"
    $htmlContent = $htmlContent -replace "【改：Job Title】", $engTitle
    $htmlContent = $htmlContent -replace "【改：Professional Service Description】", $SERVICE_DESC
    $htmlContent = $htmlContent -replace "【改：Phone】", "+886-3-490-1326"
    $htmlContent = $htmlContent -replace "【改：Email】", $EMAIL

    # 寫回檔案
    Set-Content "team\$FOLDER_NAME\index.html" $htmlContent

    Write-Color "✓ 模板已編輯" -Color Green

    # Step 4: 複製 logo
    Write-Color "[4/5] 複製 logo.svg..." -Color Blue
    Copy-Item "logo.svg" "team\$FOLDER_NAME\" -Force
    Write-Color "✓ Logo 已複製" -Color Green

    # Step 5: Git 操作
    Write-Color "[5/5] 推送到 GitHub..." -Color Blue

    # 檢查 git
    $gitCheck = & git rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Color "❌ 錯誤：不在 Git 倉庫中" -Color Red
        exit 1
    }

    # 添加檔案
    & git add "team\$FOLDER_NAME\" employees.csv

    # 檢查是否有更改
    $gitStatus = & git diff --cached --quiet 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Color "⚠️ 沒有更改需要提交" -Color Yellow
    } else {
        # 提交
        $commitMsg = "Add $CHN_NAME's ($ENG_NAME) business card"
        & git commit -m $commitMsg

        # 推送
        $pushResult = & git push origin main 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Color "❌ 推送失敗，請檢查網路連接" -Color Red
            exit 1
        }

        Write-Color "✓ 已推送到 GitHub" -Color Green
    }

    Write-Host ""
    Write-Color "════════════════════════════════════════════════════════════════" -Color Green
    Write-Color "✅ 完成！" -Color Green
    Write-Color "════════════════════════════════════════════════════════════════" -Color Green
    Write-Host ""

    Write-Color "📍 新名片網址：" -Color Blue
    Write-Color "$WEB_URL" -Color Yellow
    Write-Host ""

    Write-Color "⏳ 請稍等 1-2 分鐘，網站會自動更新" -Color Blue
    Write-Host ""

    Write-Color "📱 NFC 卡片寫入步驟：" -Color Blue
    Write-Host "  1. 開啟 NFC Tools app"
    Write-Host "  2. 點選 WRITE 標籤"
    Write-Host "  3. Add record → URL"
    Write-Host "  4. 輸入上面的網址"
    Write-Host "  5. Write/Execute → 貼卡片"
    Write-Host ""
    Write-Color "歡迎分享電子名片！🚀" -Color Green
    Write-Host ""

} catch {
    Write-Color "❌ 發生錯誤：$($_.Exception.Message)" -Color Red
    exit 1
}
