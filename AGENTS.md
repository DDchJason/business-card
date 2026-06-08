# AGENTS.md — 電子名片 repo 維護原則（上傳前必讀）

> 給任何要修改 / 上傳這個 repo 的 agent 或人：**動手 push 前先讀完這份。**

## 這個 repo 是什麼
- 公開的 GitHub Pages 靜態網站，放大地工業同事的電子名片。
- 線上網址：https://DDchJason.github.io/business-card/
- ⚠️ **整個 repo 是公開的** —— 任何人都看得到你 push 上去的每一個檔案與歷史紀錄。

---

## 🔒 最高原則：只 push 名片，絕不 push 內部檔

### ✅ 可以 push（本來就該公開）
- `team/<slug>/index.html`　← 名片頁面
- `team/<slug>/logo.svg`　　← 名片 logo
- `index.html`、`logo.svg`、`logo.png`、`README.md`、`.gitignore`、`AGENTS.md`

### 🚫 絕對不可 push（含同事個資 / 內部流程，只能留本機）
- `employees.csv`　　　← 同事姓名 / email / 電話總表（個資！）
- `add-member.ps1`、`add-member.sh`　← 自動化腳本
- `SOP.md`、`SESSION_SUMMARY.md`、`TEMPLATE.html`
- `.claude/`、以及任何 `*.csv`、`*.ps1`、`*.sh`
- 以上已寫進 `.gitignore`。**不要刪 `.gitignore`、不要用 `git add -f` 強制加這些檔。**

---

## ✅ 上傳前檢查（每次 push 前一定做）
1. 跑 `git status` → 確認待提交的**只有**名片 / logo / README，沒有任何內部檔。
2. **只用 `git add team/<slug>/`**（或明確檔名）；**不要用 `git add .` 或 `git add -A`**（會誤加內部檔）。
3. 若看到 `employees.csv`、`*.csv`、`*.ps1`、`*.sh`、`SOP.md` 出現在待提交清單 → **停下，先移除它們再繼續**。
4. **不要動到別人的名片**：只修改你這次要改的那一個 `team/<slug>/`。

---

## 🔧 常見操作

### 修改現有名片（不換網址）
```bash
# 編輯 team/<slug>/index.html 後：
git add team/<slug>/index.html
git commit -m "Update <slug>'s business card"
git push origin main
```
→ 網址不變，NFC 卡片不用重寫。

### 新增名片
- 在**本機**用 `employees.csv` + `add-member.ps1 / .sh` 產生 `team/<slug>/`（腳本已設定成只 push 名片資料夾）。
- 只把新的 `team/<slug>/` push 上去。

---

## ⚠️ 不要做的事
- ❌ 不要把工作用的 git clone 複製到 OneDrive 等同步資料夾（會殘留整包 repo）。
- ❌ 不要 push 任何含同事個資的檔案。
- ❌ 不要刪除 `.gitignore`。
- ❌ 不要修改或刪除別人的名片資料夾。

---

## 🔑 帳號安全（真正的防線）
- 這是靜態網站，沒有後端可被入侵；**唯一能改動網站的途徑 = 寫入此 repo = 登入 `DDchJason` 帳號。**
- 請務必保持 GitHub **兩步驟驗證（2FA）開啟**、密碼唯一且不外流。

---

*最後更新：2026-06-08*
