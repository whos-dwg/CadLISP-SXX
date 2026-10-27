# SXX 同層同長度斜線選取

![SXX](assets/banner.svg)

[工具儲存庫](https://github.com/whos-dwg/CadLISP-SXX) · [全部工具索引](https://github.com/whos-dwg/CadLISP-Index)

依來源圖層與曲線長度，選取同層中約為 45°／135° 的線或聚合線。

| 項目 | 內容 |
| --- | --- |
| 指令 | `SXX` |
| 檔案 | [SXX.lsp](lsp/SXX.lsp) |
| 分類 | 幾何處理 |
| 狀態 | 來源快照，實機回歸待完成 |
| 授權 | [MIT](LICENSE)，Copyright (c) 2026 whos-dwg |

[安裝](#安裝) · [操作](#操作) · [相依與設定](#相依與設定) · [已知問題](docs/KNOWN_ISSUES.md) · [驗證紀錄](docs/VALIDATION.md)

## 安裝

以 Windows 桌面版 AutoCAD 為目標。原碼使用的 Visual LISP／ActiveX、DCL 或原生命令，需在目標 AutoCAD 版本分別確認；尚未做整包年份、LT、Mac 或其他 CAD 的相容性認證。ActiveX 的平台限制見 [Autodesk](https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-AutoLISP/files/GUID-A0459510-CE7A-4206-9EAA-E25AAB569B20.htm)。

1. 下載並解壓縮本工具到固定位置，先開啟測試圖面。
2. 依公司環境把 `lsp` 資料夾加入需要的支援搜尋路徑與受信任位置。
3. 輸入 `APPLOAD`，載入 `SXX.lsp`；關閉視窗後輸入 `SXX`。

也可使用完整路徑單獨載入；下列路徑需依實際位置修改：

```lisp
(load "C:/CAD/CadLISP-SXX/lsp/SXX.lsp")
```

完成驗證後，可將這支 LISP 加入 APPLOAD 的 Startup Suite。請維持既定的 SECURELOAD 政策，使用受信任位置處理載入限制。[SECURELOAD 說明](https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core/files/GUID-541566C6-2738-49DD-87C3-C1490E924A02.htm)。

## 操作

1. 輸入 `SXX`，點選一個叉叉中的線或聚合線。
2. 程式以全圖選集搜尋同層候選物件。
3. 結果保持選取狀態，可再執行需要的編輯命令。

## 相依與設定

來源需為可由曲線 API 取得長度與端點的線／聚合線。

圖面影響：設定選取集，不刪除物件；CMDECHO 設為 0。

## 行為與限制

長度容差 0.001、角度容差 0.2°；角度由首尾點方向計算。它不會驗證每兩條斜線是否真的交叉，因此也可能選到同條件但沒有成叉的物件。

## 來源與授權

本工具依維護者確認為自行從零撰寫，或以 AI 協作從零開發。程式與本次文件採 [MIT 授權](LICENSE)，允許使用、修改與再散布，須保留授權及著作權聲明。詳細來源紀錄見 [provenance.json](metadata/provenance.json)。

## 回報與維護

回報時附 AutoCAD 完整版本、命令列錯誤與去識別的重現範例。修改前請閱讀 [CONTRIBUTING](CONTRIBUTING.md)；發行步驟見 [PUBLISHING](docs/PUBLISHING.md)。本工具可獨立維護、下載及發布，不依賴其他 CadLISP 工具儲存庫。
