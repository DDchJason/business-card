#!/bin/bash

# 大地工業電子名片 - 一鍵新增同事腳本
# 使用方式：./add-member.sh

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 清除屏幕
clear

echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}     🌟 大地工業電子名片系統 - 新增同事${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""

# 檢查必要檔案
echo -e "${YELLOW}📋 檢查系統環境...${NC}"
if [ ! -f "TEMPLATE.html" ]; then
  echo -e "${RED}❌ 錯誤：找不到 TEMPLATE.html${NC}"
  exit 1
fi

if [ ! -f "employees.csv" ]; then
  echo -e "${RED}❌ 錯誤：找不到 employees.csv${NC}"
  exit 1
fi

if [ ! -f "logo.svg" ]; then
  echo -e "${RED}❌ 錯誤：找不到 logo.svg${NC}"
  exit 1
fi

echo -e "${GREEN}✓ 檔案檢查完成${NC}"
echo ""

# 獲取用戶輸入
echo -e "${BLUE}請輸入同事資訊：${NC}"
echo ""

read -p "1. 中文名字: " CHN_NAME
read -p "2. 英文名 (例: Xiaoming Wang): " ENG_NAME
read -p "3. 職稱 (可空白，例: Sales Manager): " JOB_TITLE
read -p "4. 專業服務 (例: 銷售與客戶關係管理): " SERVICE_DESC
read -p "5. 郵件 (例: xiaoming@goodcomer.com): " EMAIL
read -p "6. 電話 (例: (03)490-2000): " PHONE
read -p "7. 資料夾名稱 (推薦: x.wang): " FOLDER_NAME

echo ""

# 驗證輸入
if [ -z "$CHN_NAME" ] || [ -z "$ENG_NAME" ] || [ -z "$SERVICE_DESC" ] || [ -z "$EMAIL" ] || [ -z "$PHONE" ] || [ -z "$FOLDER_NAME" ]; then
  echo -e "${RED}❌ 錯誤：必填欄位不能為空${NC}"
  exit 1
fi

# 生成網址
WEB_URL="https://DDchJason.github.io/business-card/team/${FOLDER_NAME}/"

echo ""
echo -e "${YELLOW}📝 即將建立以下資訊：${NC}"
echo "  名字: ${CHN_NAME} (${ENG_NAME})"
echo "  職稱: ${JOB_TITLE:-'(空白)'}"
echo "  專業: ${SERVICE_DESC}"
echo "  郵件: ${EMAIL}"
echo "  電話: ${PHONE}"
echo "  資料夾: ${FOLDER_NAME}"
echo "  網址: ${WEB_URL}"
echo ""

read -p "確認無誤？(y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${YELLOW}⏹️ 已取消${NC}"
  exit 1
fi

echo ""
echo -e "${YELLOW}⚙️ 處理中...${NC}"
echo ""

# Step 1: 更新 CSV
echo -e "${BLUE}[1/5]${NC} 更新 employees.csv..."

# 檢查資料夾是否已存在
if [ -d "team/${FOLDER_NAME}" ]; then
  echo -e "${YELLOW}⚠️ 資料夾已存在，將覆蓋舊的檔案${NC}"
fi

# 將新行添加到 CSV（檢查是否已存在相同記錄）
CSV_LINE="${CHN_NAME},${ENG_NAME},${JOB_TITLE},${SERVICE_DESC},${EMAIL},${PHONE},${FOLDER_NAME},${WEB_URL}"

# 檢查是否已在 CSV 中
if grep -q "^${CHN_NAME}," employees.csv 2>/dev/null; then
  echo -e "${YELLOW}⚠️ 同事已存在於 CSV，正在更新...${NC}"
  # 使用臨時檔案更新
  grep -v "^${CHN_NAME}," employees.csv > employees.csv.tmp
  mv employees.csv.tmp employees.csv
fi

# 添加新行
echo "${CSV_LINE}" >> employees.csv
echo -e "${GREEN}✓ CSV 已更新${NC}"

# Step 2: 建立資料夾
echo -e "${BLUE}[2/5]${NC} 建立資料夾 team/${FOLDER_NAME}/..."
mkdir -p "team/${FOLDER_NAME}"
echo -e "${GREEN}✓ 資料夾已建立${NC}"

# Step 3: 複製並編輯模板
echo -e "${BLUE}[3/5]${NC} 複製並編輯模板..."

# 複製 TEMPLATE.html
cp TEMPLATE.html "team/${FOLDER_NAME}/index.html"

# 編輯 HTML 檔案
sed -i "s/【改：名字】<br>(【改：English Name】)/${CHN_NAME}<br>(${ENG_NAME})/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：職稱】/${JOB_TITLE}/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：專業服務描述】/${SERVICE_DESC}/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：電話】/${PHONE}/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：郵件】/${EMAIL}/g" "team/${FOLDER_NAME}/index.html"

# 英文版本
ENG_TITLE="${JOB_TITLE:-Professional}"
sed -i "s/【改：English Name】<br>(【改：Nickname】)/${ENG_NAME}<br>(${ENG_NAME})/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：Job Title】/${ENG_TITLE}/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：Professional Service Description】/${SERVICE_DESC}/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：Phone】/+886-3-490-1326/g" "team/${FOLDER_NAME}/index.html"
sed -i "s/【改：Email】/${EMAIL}/g" "team/${FOLDER_NAME}/index.html"

echo -e "${GREEN}✓ 模板已編輯${NC}"

# Step 4: 複製 logo
echo -e "${BLUE}[4/5]${NC} 複製 logo.svg..."
cp logo.svg "team/${FOLDER_NAME}/"
echo -e "${GREEN}✓ Logo 已複製${NC}"

# Step 5: Git 操作
echo -e "${BLUE}[5/5]${NC} 推送到 GitHub..."

# 檢查 git 狀態
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo -e "${RED}❌ 錯誤：不在 Git 倉庫中${NC}"
  exit 1
fi

# 添加檔案
git add "team/${FOLDER_NAME}/" employees.csv

# 檢查是否有更改
if git diff --cached --quiet; then
  echo -e "${YELLOW}⚠️ 沒有更改需要提交${NC}"
else
  # 提交
  COMMIT_MSG="Add ${CHN_NAME}'s (${ENG_NAME}) business card"
  git commit -m "${COMMIT_MSG}"

  # 推送
  if git push origin main 2>&1 | grep -q "error"; then
    echo -e "${RED}❌ 推送失敗，請檢查網路連接${NC}"
    exit 1
  fi

  echo -e "${GREEN}✓ 已推送到 GitHub${NC}"
fi

echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ 完成！${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${BLUE}📍 新名片網址：${NC}"
echo -e "${YELLOW}${WEB_URL}${NC}"
echo ""
echo -e "${BLUE}⏳ 請稍等 1-2 分鐘，網站會自動更新${NC}"
echo ""
echo -e "${BLUE}📱 NFC 卡片寫入步驟：${NC}"
echo "  1. 開啟 NFC Tools app"
echo "  2. 點選 WRITE 標籤"
echo "  3. Add record → URL"
echo "  4. 輸入上面的網址"
echo "  5. Write/Execute → 貼卡片"
echo ""
echo -e "${GREEN}歡迎分享電子名片！🚀${NC}"
echo ""
