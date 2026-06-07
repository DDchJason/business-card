# 大地工業電子名片管理系統 - 完整 SOP

## 📱 系統概述

本系統用於管理大地工業團隊成員的電子名片，每位同事都有獨立的網址可透過 NFC 卡片分享。

**核心特色：**
- ✅ 每位同事有獨立的網頁名片
- ✅ 支援中英文雙語
- ✅ 可透過 NFC 卡片掃描打開
- ✅ 修改內容後 30 秒內自動更新
- ✅ 網址永不改變（地址寫進卡片後無需更改）

---

## 🏗️ 資料夾結構

```
business-card/
├── README.md              # 系統說明
├── TEMPLATE.html          # 新增名片的模板
├── employees.csv          # 同事資訊管理表
├── logo.svg              # 公司 logo
├── logo.png              # logo 備用版本
├── add-member.sh          # 一鍵新增同事腳本
└── team/                  # 所有同事名片資料夾
    ├── j.lin/            # 林家豪 (Jason)
    │   ├── index.html
    │   └── logo.svg
    └── c.chiu/           # 邱于娟 (Christina)
        ├── index.html
        └── logo.svg
```

---

## 👥 新增同事完整流程

### 方案 A：一鍵自動化執行（推薦）

```bash
./add-member.sh
```

按照提示輸入同事資訊，系統會自動完成所有步驟！

### 方案 B：手動執行

#### **Step 1：決定名片編號**

使用簡短、有辨識度的英文名稱（通常為名字縮寫或姓氏）

| 同事名字 | 英文名 | 推薦編號 | 網址 |
|--------|--------|---------|------|
| 王小明 | Xiaoming Wang | x.wang | https://DDchJason.github.io/business-card/team/x.wang/ |
| 李美麗 | Meili Li | m.li | https://DDchJason.github.io/business-card/team/m.li/ |
| 陳大衛 | David Chen | d.chen | https://DDchJason.github.io/business-card/team/d.chen/ |

**命名規則：** `[首字母].[姓氏]` 或 `[首字母][姓氏縮寫]`

---

#### **Step 2：更新 employees.csv**

打開 `employees.csv`，新增一行：

```csv
名字,英文名,職稱,專業服務,郵件,電話,資料夾名稱,網址
王小明,Xiaoming Wang,Sales Manager,銷售與客戶關係管理,xiaoming@goodcomer.com,(03)490-2000,x.wang,https://DDchJason.github.io/business-card/team/x.wang/
```

**欄位說明：**
- **名字**：中文全名
- **英文名**：英文完整名稱
- **職稱**：英文職稱（可選，留空也可以）
- **專業服務**：一句話描述專長
- **郵件**：公司電子信箱
- **電話**：主要聯絡電話
- **資料夾名稱**：簡短英文代號（決定網址）
- **網址**：自動生成 `https://DDchJason.github.io/business-card/team/[資料夾名稱]/`

---

#### **Step 3：複製並編輯模板**

1. **建立資料夾**
   ```bash
   mkdir -p team/x.wang
   ```

2. **複製範本檔案**
   ```bash
   cp TEMPLATE.html team/x.wang/index.html
   cp logo.svg team/x.wang/
   ```

3. **編輯 `team/x.wang/index.html`**

   用文字編輯器打開，搜尋並替換以下內容：

   **中文版本（約 250-300 行）：**
   ```html
   <!-- 名字 -->
   <div class="name">王小明<br>(Xiaoming Wang)</div>
   
   <!-- 職稱 -->
   <div class="title">Sales Manager</div>
   
   <!-- 專業服務 -->
   <div class="title-desc">銷售與客戶關係管理</div>
   
   <!-- 電話 -->
   <div class="contact-value">(03)490-2000</div>
   
   <!-- 郵件 -->
   <div class="contact-value"><a href="mailto:xiaoming@goodcomer.com">xiaoming@goodcomer.com</a></div>
   ```

   **英文版本（約 350-400 行）：**
   ```html
   <!-- 名字 -->
   <div class="name">Xiaoming Wang<br>(Xiaoming)</div>
   
   <!-- 職稱 -->
   <div class="title">Sales Manager</div>
   
   <!-- 專業服務 -->
   <div class="title-desc">Sales and Customer Relationship Management</div>
   
   <!-- 電話 -->
   <div class="contact-value">+886-3-490-2000</div>
   
   <!-- 郵件 -->
   <div class="contact-value"><a href="mailto:xiaoming@goodcomer.com">xiaoming@goodcomer.com</a></div>
   ```

   **核心服務保持固定（不用改）：**
   - 圖面評估 / Drawing Assessment
   - 鋁無縫管 / Seamless Tubes
   - 鋼索束頭 / Ferrules

---

#### **Step 4：推送到 GitHub**

```bash
# 進入倉庫目錄
cd /path/to/business-card

# 檢查狀態
git status

# 添加新檔案
git add employees.csv team/x.wang/

# 提交
git commit -m "Add Xiaoming Wang's business card"

# 推送
git push origin main
```

**推送成功的標誌：**
```
To https://github.com/DDchJason/business-card.git
   xxxxx..yyyyy  main -> main
✓ 推送完成！
```

---

#### **Step 5：等待部署並測試**

1. **等待 1-2 分鐘**（GitHub Pages 自動部署）

2. **打開瀏覽器測試**
   ```
   https://DDchJason.github.io/business-card/team/x.wang/
   ```

3. **檢查內容**
   - ✅ 名字和職稱顯示正確
   - ✅ 聯絡方式可點擊複製
   - ✅ 中英文都能正常切換
   - ✅ 核心服務正確顯示

---

#### **Step 6：寫入 NFC 卡片**

用 **NFC Tools** 應用程式：

1. 開啟 NFC Tools → **WRITE** 標籤
2. 點 **Add record** → 選 **URL**
3. 輸入網址：`https://DDchJason.github.io/business-card/team/x.wang/`
4. 點 **Write/Execute**
5. 將卡片貼到手機 NFC 區域（通常在背部上方）

**測試：** 別人用支援 NFC 的手機接觸卡片 → 自動打開網頁名片 ✅

---

## 🔄 修改現有名片

### 修改個人資訊（推薦）

如果只想修改名字、職稱、郵件或電話，**不需要改網址，也不用重寫 NFC 卡片**

**做法：**
1. 編輯 `team/[名字]/index.html`（只改 HTML 檔案內容）
2. 保存檔案
3. 推送到 GitHub
   ```bash
   git add team/x.wang/index.html
   git commit -m "Update Xiaoming Wang's contact info"
   git push origin main
   ```
4. 30 秒後自動更新，訪問者重新整理就能看到新內容

### 修改資料夾名稱（改網址）

如果需要改資料夾名稱（改網址），**NFC 卡片必須重寫**

**做法：**
1. 更新 CSV 中的「資料夾名稱」和「網址」
2. 建立新的資料夾並複製檔案
3. 刪除舊資料夾
4. 推送到 GitHub
5. 用 NFC Tools 重新寫入新網址到卡片

---

## 📋 同事資訊表管理

### 查看所有同事

打開 `employees.csv`，可以看到所有同事的：
- 名字、英文名、職稱
- 聯絡方式
- 資料夾名稱和網址

### 更新資訊

修改 CSV 中的任何欄位後推送：
```bash
git add employees.csv
git commit -m "Update employees info"
git push origin main
```

---

## ⚙️ 一鍵新增腳本使用說明

### 系統要求

- Windows 10+ 或 macOS / Linux
- Git 已安裝
- Bash 環境（Windows 用戶可用 Git Bash 或 WSL）

### 使用方式

```bash
cd /path/to/business-card
./add-member.sh
```

### 互動式提示

腳本會依序詢問：

```
🌟 大地工業電子名片 - 新增同事

請輸入同事資訊：

1. 中文名字: 王小明
2. 英文名: Xiaoming Wang
3. 職稱 (可空白): Sales Manager
4. 專業服務: 銷售與客戶關係管理
5. 郵件: xiaoming@goodcomer.com
6. 電話: (03)490-2000
7. 資料夾名稱 (推薦: x.wang): x.wang

✓ 已完成以下操作：
  - 更新 employees.csv
  - 建立 team/x.wang/ 資料夾
  - 複製並編輯模板
  - 推送到 GitHub

✅ 完成！新網址：
https://DDchJason.github.io/business-card/team/x.wang/

⏳ 請稍等 1-2 分鐘，網站會自動更新
```

---

## 🎯 常見工作流程

### 場景 1：新同事入職

1. 執行 `./add-member.sh`
2. 填寫資訊（自動完成所有步驟）
3. 等待 1-2 分鐘
4. 用 NFC Tools 寫入卡片
5. 完成！

### 場景 2：更新同事職稱/郵件

1. 編輯 `team/[名字]/index.html`
2. 修改對應內容
3. Git 推送
4. 30 秒後更新
5. **卡片不用改**（地址不變）

### 場景 3：重新設計名片外觀

1. 編輯 `TEMPLATE.html` 中的 CSS
2. 測試修改效果
3. Git 推送
4. 所有同事的名片都會自動更新

### 場景 4：統一更新公司訊息

1. 編輯 `team/[名字]/index.html` 中的公司介紹
2. 或編輯 `TEMPLATE.html` 讓新建立的名片自動包含
3. Git 推送
4. 完成

---

## 🔐 NFC 卡片寫入指南

### 軟體準備

**iOS：** 使用內建的 NFC 讀寫功能或 Shortcuts App
**Android：** 下載 "NFC Tools" 應用程式（免費）

### 詳細步驟

1. **開啟 NFC Tools**
   - Android 用戶開啟 NFC Tools App

2. **進入 WRITE 標籤**
   - 點擊頁面底部的 "WRITE" 按鈕

3. **新增記錄**
   - 點 "Add record"
   - 選擇 "URL"

4. **輸入網址**
   ```
   https://DDchJason.github.io/business-card/team/x.wang/
   ```

5. **寫入卡片**
   - 點 "Write/Execute"
   - 將卡片緊貼手機背部（NFC 天線通常在上方）
   - 保持靜止 2-3 秒
   - 出現 "成功" 訊息即完成

6. **測試掃描**
   - 用另一支手機掃描卡片
   - 應該會自動打開網頁

---

## 📞 常見問題

**Q: 修改了名片多久會更新？**
A: GitHub Pages 通常在 30 秒到 2 分鐘內自動部署更新

**Q: 如果頁面沒有更新，怎麼辦？**
A: 用硬刷新：
- Windows/Linux：`Ctrl + Shift + R`
- Mac：`Cmd + Shift + R`

**Q: 可以改公司 logo 嗎？**
A: 不建議。公司 logo 由 IT 統一管理，有特殊需求請聯絡 IT

**Q: 能改名片的設計和顏色嗎？**
A: 可以，但要修改 HTML 中的 CSS 部分，有困難可以聯絡開發者

**Q: 舊的網址失效了，該怎麼辦？**
A: 如果改了資料夾名稱，舊網址會失效。NFC 卡片必須用新網址重新寫入

**Q: 可以有多個名片網址嗎？**
A: 可以，每位同事都有獨立的網址，放在 `team/` 目錄下

---

## 📞 聯絡與支援

- **系統問題**：聯絡開發者
- **NFC 寫入問題**：確保手機支援 NFC，嘗試不同品牌的卡片
- **內容更新**：直接編輯 HTML 檔案或聯絡管理員

---

## ✅ 推送前檢查清單

**每次推送 Git 前，必須檢查以下項目：**

### 1. HTML 結構檢查
- [ ] 所有 `【改：...】` 都已替換為實際內容
- [ ] 沒有遺漏的佔位符
- [ ] HTML 標籤正確閉合

### 2. Logo 路徑檢查 ⚠️
- [ ] Logo 路徑：`logo.svg`（同目錄，**不是** `../logo.svg`）
- [ ] Logo 檔案確實存在於 `team/[名字]/` 目錄中
- [ ] Logo 檔案大小正常（> 1MB）

### 3. 內容檢查
- [ ] 名字、英文名正確
- [ ] 職稱正確
- [ ] 專業服務正確
- [ ] 聯絡方式正確（電話、郵件）
- [ ] LINE ID 是 @dadi999（公版）

### 4. 功能檢查
- [ ] vCard 下載按鈕已移除
- [ ] 頁脚版權已移除
- [ ] 分享按鈕正常

---

## ✅ 推送後檢查清單

**推送到 GitHub 後，必須打開瀏覽器檢查：**

### 1. 等待部署（1-2 分鐘）
- [ ] GitHub Pages 部署完成

### 2. Logo 檢查 ⚠️ 最關鍵
- [ ] Logo 圖片顯示正常（紅色旗幟，不是文字）
- [ ] Logo 不是顯示 "GOODCOMER Logo" 文字

### 3. 頁面元素檢查
- [ ] 頁面標題正確
- [ ] 名字、英文名、職稱、專業描述顯示正確
- [ ] 核心服務正確（圖面評估、客製化開模、擠型製造）
- [ ] 主要產品正確（超大鋁擠型、鋁無縫管、鋼索束頭）

### 4. 聯絡方式檢查
- [ ] 電話正確
- [ ] 郵件正確
- [ ] 網站連結正確
- [ ] **LINE 官方帳號 @dadi999 顯示**
- [ ] 沒有 vCard 下載按鈕
- [ ] 沒有頁脚版權

### 5. 視覺檢查
- [ ] 頁面排版正常，內容沒有跑掉
- [ ] 中英文切換正常
- [ ] 分享按鈕正常

---

**歡迎分享你的電子名片！** 🚀

*最後更新：2026-06-07*
