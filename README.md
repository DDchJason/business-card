# 大地工業電子名片

公開的電子名片網站，提供大地工業團隊成員的線上名片（支援中英雙語，可透過 NFC 卡片分享）。

🔗 **線上網址**：https://DDchJason.github.io/business-card/

## 團隊名片

| 成員 | 名片網址 |
|------|---------|
| 林家豪 Jason Lin | https://DDchJason.github.io/business-card/team/j.lin/ |
| 邱于娟 Christina Chiu | https://DDchJason.github.io/business-card/team/c.chiu/ |

## 內容結構（公開部分）

```
business-card/
├── index.html            # 首頁名片
├── logo.svg / logo.png   # 公司 logo
├── team/<slug>/          # 各成員名片
│   └── index.html + logo.svg
├── AGENTS.md             # 維護與上傳原則（修改前必讀）
└── .gitignore
```

## 維護方式

修改或新增名片前，請先閱讀 **[AGENTS.md](AGENTS.md)**。

重點原則：這是**公開** repo，只 push 名片頁面；內部管理檔（同事名單、腳本等）一律留在本機、不上傳。

---

*由大地工業維護*
