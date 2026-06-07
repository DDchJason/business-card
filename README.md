# 大地工業電子名片管理系統

## 📱 電子名片概述

本倉庫用於管理大地工業團隊成員的電子名片。  
網址：https://DDchJason.github.io/business-card/

## 📂 資料夾結構

```
business-card/
├── index.html           # 林家豪 (Jason) 的名片
├── logo.svg            # 公司 logo (推薦使用)
├── logo.png            # logo 備用版本
├── team/               # 其他同事名片資料夾
│   ├── colleague1/
│   │   ├── index.html
│   │   └── logo.svg
│   └── colleague2/
│       ├── index.html
│       └── logo.svg
├── employees.csv       # 同事名片資訊管理表
└── TEMPLATE.html       # 新增名片的模板

```

## 🔧 如何修改自己的名片

編輯 `index.html` 檔案，找到以下部分並修改：

### 修改內容位置

**中文版本 (約 200-250 行)：**
```html
<!-- 個人信息 -->
<div class="person-section">
    <div class="name">林家豪<br>(Jason)</div>  <!-- 改這裡 -->
    <div class="title">Product Marketer</div>  <!-- 改職稱 -->
    <div class="title-desc">鋁合金擠型開發諮詢顧問</div>  <!-- 改專業 -->
</div>

<!-- 服務 -->
<div class="service-section">
    <div class="service-items">
        <div class="service-item">圖面評估</div>  <!-- 改服務1 -->
        <div class="service-item">客製化開模</div>  <!-- 改服務2 -->
        <div class="service-item">擠型製造</div>   <!-- 改服務3 -->
    </div>
</div>

<!-- 聯絡方式 -->
<div class="contact-item" onclick="copyToClipboard('(03)490-1326')">
    <div class="contact-value">(03)490-1326</div>  <!-- 改電話 -->
</div>
<div class="contact-item" onclick="copyToClipboard('jason@goodcomer.com')">
    <div class="contact-value"><a href="mailto:jason@goodcomer.com">jason@goodcomer.com</a></div>  <!-- 改郵件 -->
</div>
```

**英文版本 (約 300-350 行)：**
同樣位置，改英文版本的內容

### 修改完後
1. 儲存檔案 (Ctrl+S)
2. 推送到 GitHub：
   ```bash
   git add index.html
   git commit -m "Update Jason's business card"
   git push origin main
   ```
3. 稍等 30 秒，網站自動更新

## 👥 為同事新增名片

### 方案 A：一鍵自動化（推薦！）✨

**Windows 用戶：**
```bash
powershell -ExecutionPolicy Bypass -File add-member.ps1
```

**Mac / Linux 用戶：**
```bash
chmod +x add-member.sh
./add-member.sh
```

按照提示輸入同事資訊，系統會自動完成所有步驟！

---

### 方案 B：手動執行

#### Step 1: 準備資訊
在 `employees.csv` 中新增一行（參考下方表格）

#### Step 2: 複製模板
- 複製 `TEMPLATE.html` → `team/同事名字/index.html`
- 修改對應的名字、職稱、服務、郵件、電話

#### Step 3: 上傳到 GitHub
```bash
# 建立資料夾
mkdir -p team/同事名字

# 複製檔案
cp TEMPLATE.html team/同事名字/index.html
cp logo.svg team/同事名字/

# 推送
git add team/
git commit -m "Add 同事名字's business card"
git push origin main
```

#### Step 4: 獲得網址
```
https://DDchJason.github.io/business-card/team/同事名字/
```

## 📋 同事名片資訊表 (employees.csv)

| 名字 | 職稱 | 專業服務 | 郵件 | 電話 | 網址 |
|------|------|---------|------|------|------|
| 林家豪 | Product Marketer | 鋁合金擠型開發諮詢顧問 | jason@goodcomer.com | (03)490-1326 | https://DDchJason.github.io/business-card/ |
| 同事名字 | 職稱 | 服務描述 | email@goodcomer.com | 電話 | https://DDchJason.github.io/business-card/team/同事名字/ |

## 📝 編輯建議

- **名字**：包含英文名（括號）
- **職稱**：用英文或中文，保持一致
- **專業服務**：簡述 1-2 行
- **服務項目**：最多 3 項，簡潔明了
- **郵件**：公司信箱
- **電話**：主要聯絡電話

## 🔐 NFC 卡片寫入

用 **NFC Tools** 應用程式寫入電子名片網址：

1. 開啟 NFC Tools → **WRITE** 標籤
2. **Add record** → 選 **URL**
3. 輸入你的網址（如上方網址）
4. 點 **Write/Execute**
5. 貼卡片到手機 NFC 區域

別人用支援 NFC 的手機接觸卡片 → 自動打開你的電子名片

## 🔄 版本控制

每次修改後會自動：
- 推送到 GitHub
- 網站 30 秒內更新
- 保留修改記錄

## 📞 常見問題

**Q: 改了名片多久會更新？**  
A: 30 秒內會自動更新

**Q: 可以改 logo 嗎？**  
A: 不建議。如需修改公司標識，請詢問 IT

**Q: 要怎麼改版整個設計？**  
A: 編輯 HTML 中的 CSS 部分（<style> 標籤）或聯絡開發者

---

**歡迎分享你的電子名片！** 🚀
