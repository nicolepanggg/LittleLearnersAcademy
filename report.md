# Little Learners Academy 網站分析報告

## 1. 專案概述

這個專案是一個以 Flutter 製作的幼兒教育互動網站 / Web App，主題為 Little Learners Academy。整體定位偏向學齡前兒童的啟蒙學習介面，重點在於：

- 清楚的大圖像
- 高彩度但不刺眼的色彩
- 大尺寸可點擊區塊
- 簡單直接的互動流程
- 英文 / 繁體中文雙語切換
- 部分文字與內容具備語音朗讀能力

從技術架構來看，這不是傳統 HTML/CSS/JS 網站，而是 Flutter Web 應用。也就是說，整個前端畫面由 Flutter widget 組成，透過 Riverpod 管理狀態，最後輸出成 Web 版本執行。

---

## 2. 技術結構分析

### 2.1 技術棧

- Framework: Flutter
- Language: Dart
- State Management: Riverpod + riverpod_annotation + code generation
- Localization: Flutter l10n + ARB 語系檔
- Speech: 自訂 SpeechService + Web Speech API facade
- Target: Web 為主，也保留 Android / iOS / Windows / Linux / macOS 結構

### 2.2 入口結構

應用的啟動路徑如下：

1. `lib/main.dart`
2. `ProviderScope`
3. `LittleLearnersApp`
4. `MaterialApp`
5. `AppShell`
6. 根據目前 tab 顯示對應頁面

這種結構的優點是：

- 全域狀態集中管理
- 主題、語系、導航可以從 app 層統一控制
- 頁面之間切換邏輯清楚
- 適合中小型教育互動型產品

### 2.3 目錄結構分析

`lib/` 下大致可分為以下幾層：

#### app

- `app/little_learners_app.dart`
- 負責 MaterialApp、主題、語系、scroll behavior、home shell

#### core

- `core/theme/`: 顏色與主題
- `core/widgets/`: 全站共用 widget
- `core/assets/`: 圖片路徑常數
- `core/speech/`: 語音服務封裝
- `core/scroll/`: 滾動行為調整

#### features

依照功能拆分：

- `home`
- `animals`
- `numbers`
- `food`
- `settings`
- `navigation`

這是標準的 feature-first 結構，優點是功能模組邏輯集中，不會把所有頁面與元件混在一起。

#### l10n

- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`
- `lib/l10n/app_localizations.dart`

此區負責英文與繁體中文文案管理。

---

## 3. 畫面與資訊架構分析

### 3.1 主要頁面流程

此應用以底部導航列為核心，包含 5 個主頁籤：

1. Home
2. Animals
3. Numbers
4. Food
5. Settings

這種結構非常適合兒童學習產品，因為：

- 入口固定
- 功能不深層巢狀
- 容易形成重複操作記憶
- 不需要複雜導覽理解成本

### 3.2 AppShell 的角色

`features/navigation/presentation/app_shell.dart` 是整個 UI 的畫面殼層，主要作用：

- 上層容器使用 `Scaffold`
- `body` 顯示目前頁面
- `bottomNavigationBar` 固定顯示底部導覽列

這代表專案並沒有用 Navigator 進行多頁堆疊切換，而是採用「單殼層 + 切換內容頁」的模式。這種做法簡單、穩定，適合此專案。

---

## 4. 狀態管理分析

### 4.1 使用 Riverpod 的方式

專案用 `@riverpod` 與 `@Riverpod` 建立多個 provider，這些 provider 主要負責：

- 目前頁籤
- 深色模式
- 語言切換
- 遊戲音量
- 音樂音量
- 家長模式解鎖
- 數字頁面當前數字
- 首頁進度追蹤

### 4.2 目前主要 provider

#### `CurrentTab`

用途：切換底部頁面與維護返回歷史。

優點：

- 邏輯直接
- 可支援 back 功能
- 同時串接進度追蹤

注意點：

- 目前含有 `print()` debug 訊息，正式版建議移除

#### `NightMode`

用途：控制整站 light / dark theme。

現況：僅存在記憶體中，重新整理後不會保存。

#### `LanguageController`

用途：中英文切換。

現況：預設為英文，切換後也不會持久化保存。

#### `GameVolume`

用途：控制遊戲音效 / 語音音量。

目前已經串接到：

- Animals 語音
- Numbers 朗讀
- Food 語音

現況：已透過統一的 `SpeechService` facade 控制主要語音輸出。

#### `MusicVolume`

用途：理論上控制背景音樂。

現況：provider 已存在，但設定畫面目前實際 UI 被註解掉，因此功能尚未完整接上。

#### `ProgressTracker`

用途：記錄 Animals / Numbers / Food 三個學習頁是否曾造訪。

現況：

- 具備 `keepAlive: true`
- 只記錄指定頁籤
- 使用 `Set<AppTab>` 避免重複計算

但首頁中的 `ProgressBubbles` 目前被註解掉，因此功能尚未真正展示到畫面。

---

## 5. 視覺設計與顏色運用分析

### 5.1 配色策略

專案的主色配置定義在 `core/theme/app_colors.dart`。

整體顏色方向可分為：

#### 背景系

- `background`: 米白暖色
- `surfaceContainer*`: 淺奶油 / 淺灰米色層次
- `surfaceLowest`: 白色

這類色彩讓畫面看起來溫暖、柔和、不刺激，很適合幼兒教育場景。

#### 主互動色

- `primaryContainer`: 明亮金黃
- `secondaryContainer`: 天空藍
- `tertiaryContainer`: 草地綠

三組主色剛好對應主要學習模組：

- Numbers 偏黃
- Animals 偏藍
- Food 偏綠

這樣的顏色編排很好，因為能建立兒童對功能分類的視覺記憶。

#### 深色模式色彩

- `nightBackground`
- `nightSurface`
- `nightAnimals`
- `nightNumbers`
- `nightFood`

深色模式不是單純全站轉黑，而是為不同模組保留帶色調的夜間版塊色，這點在視覺上是加分的。

### 5.2 顏色使用評價

優點：

- 色彩辨識度高
- 模組分類清楚
- 陰影色與底色搭配有一致性
- 具有兒童產品應有的活力感

可優化點：

- 部分文字直接寫死 `Colors.black`，在暗色主題下可維護性較差
- 某些元件顏色邏輯分散在頁面內部，未完全抽成設計 token
- flag 區塊、部分 icon 顏色、進度元件顏色仍有局部硬編碼

---

## 6. 主題與字體系統分析

主題定義在 `core/theme/app_theme.dart`。

### 6.1 目前字級配置

- `headlineLarge`: 32
- `headlineMedium`: 28
- `titleLarge`: 24
- `bodyLarge`: 20
- `bodyMedium`: 18
- `labelLarge`: 16

這套字級對兒童介面是合理的，因為：

- 標題夠大
- 文案清晰
- 可點擊標籤容易辨識

### 6.2 主題設計優點

- light / dark 主題切換集中管理
- 文字顏色可跟著主題變化
- `ColorScheme.fromSeed` 與自訂 textTheme 混合使用，保有 Material 3 基礎能力

### 6.3 可優化點

- 字體目前使用 Flutter 預設字體系統，品牌感較弱
- 若未來要更貼近 Figma，可考慮導入更童趣但清楚的字型

---

## 7. 每個主要頁面的製作分析

### 7.1 Home 首頁分析

首頁由以下區塊組成：

1. Top App Bar
2. Owl 圓形主視覺
3. 問候文字
4. Progress 區塊位置
5. Animals / Numbers 雙卡片
6. Food 大卡片

#### 製作方式

- 使用 `Column + SingleChildScrollView`
- 圖像採 `RoundImage`
- 卡片採 `ActivityCard` 與 `TactileCard`
- 點擊時透過 `navigation.select(AppTab.xxx)` 切換頁面

#### 優點

- 畫面組裝清楚
- 主功能入口突出
- 視覺焦點集中

#### 問題與現況

- `ProgressBubbles` 已實作但目前被註解掉
- 這表示首頁原本規劃有進度視覺，但功能尚未完整接回 UI

### 7.2 Animals 頁面分析

內容由：

- 頁首標題
- 副標說明
- 水平滑動動物卡片組成

#### 製作方式

- 外層 `SingleChildScrollView`
- 內層 `SizedBox(height: 448)` 搭配水平 `ListView.separated`
- 每張卡片用 `AnimalCard`

#### 互動

- 按鈕 1: 播放動物叫聲文字
- 按鈕 2: 朗讀動物名稱

#### 評價

- 卡片式設計很符合兒童產品
- 互動目標明確
- 橫向滑動能建立探索感

#### 注意點

- 動物聲音目前其實是用 TTS 說出擬聲字，並非真實動物音效
- 若未來要升級，可換成真實音檔資產

### 7.3 Numbers 頁面分析

此頁面是數字教學模組。

#### 組成

- 標題與說明
- 數字展示卡
- 蘋果數量對應圖
- 可點擊朗讀文字標籤
- 左右切換按鈕
- 5 個數字進度點

#### 製作方式

- `_NumberCard` 用 `ConsumerWidget`
- 語音行為透過統一 `SpeechService` facade 處理
- 點擊文字標籤時朗讀完整句子，如 Five Apples

#### 優點

- 數字與物件數量對應直覺
- 點擊文字朗讀有助語言學習
- 互動難度低

#### 目前現況

- Numbers 已不再單獨維護一套 TTS 實作
- 目前會跟著 `languageControllerProvider` 切換 `en-US` / `zh-TW`
- 音量也與 Settings 的 `gameVolumeProvider` 同步

#### 可優化點

- Web 平台最終使用哪個 voice，仍取決於瀏覽器實際提供的 voice 清單
- 若要更高一致性，可改成預錄音檔或雲端語音服務

### 7.4 Food 頁面分析

此頁面展示食物圖卡與語音。

#### 組成

- 標題
- 副標
- 2x2 Grid 圖像
- 每個食物右下角有音量按鈕

#### 製作方式

- 外層 `SingleChildScrollView`
- 內部 `GridView.builder` 設 `shrinkWrap: true` 與 `NeverScrollableScrollPhysics`
- 音量圖示按鈕使用 `Positioned` 疊在圓形圖片上

#### 優點

- 視覺簡單可愛
- 按鈕位置明確
- 網格結構適合固定數量教材

#### 可優化點

- 若食物數量增加，需要做響應式欄數與高度調整
- 語音目前依賴 Web Speech / service 封裝，在不同平台發音品質可能不同

### 7.5 Settings 頁面分析

此頁面是目前功能最複合的一頁。

#### 組成

- Sounds 區塊
- Language 區塊
- Parent Gate 區塊

#### 製作方式

- 多個 `_Panel` 與自訂 section widgets 組合
- 語言區使用圓形按鈕做語系選擇
- 已加入真實國旗圖片資產

#### 目前現況

- Game Sounds 可控制語音音量
- Music 功能暫時未完整顯示
- Language 支援 English / Traditional Chinese
- Parent Gate 用簡單算術題做家長驗證

#### 可優化點

- 語言按鈕目前顯示的主要文字被部分註解，只留下 nativeLabel
- 若要對齊設計稿，建議統一決定顯示一行還是兩行語言名稱
- 可加入已選中狀態的更強提示，例如小圖示或勾選標記

---

## 8. 每一個核心 widget 介紹

以下為專案中重要 widget 的職責說明。

### 8.1 `LittleLearnersApp`

位置：`lib/app/little_learners_app.dart`

作用：

- 建立整個 MaterialApp
- 掛載主題、深色模式、語系、本地化委派
- 指定首頁殼層 `AppShell`

### 8.2 `AppShell`

位置：`lib/features/navigation/presentation/app_shell.dart`

作用：

- 作為整個應用的主容器
- 根據當前 tab 決定顯示哪一頁
- 固定底部導航列

### 8.3 `LearnerBottomNavBar`

位置：`lib/features/navigation/presentation/bottom_nav_bar.dart`

作用：

- 顯示 5 個底部主功能按鈕
- 高亮當前頁面
- 負責頁籤切換互動

設計特點：

- 圓角容器
- 選中狀態有凸起陰影
- 符合兒童 UI 的實體按鈕感

### 8.4 `LearnerTopAppBar`

位置：`lib/core/widgets/top_app_bar.dart`

作用：

- 提供全站統一頁首
- 左側返回按鈕
- 中央標題
- 右側頭像 / 切換夜間模式按鈕

注意：

- 標題 `Little Learner` 目前為硬編碼，若要完整多語系，建議也移入 l10n

### 8.5 `TactileCard`

位置：`lib/core/widgets/tactile_card.dart`

作用：

- 建立有厚度、卡通按壓感的共用卡片

特點：

- 粗邊框
- 明顯底部陰影
- 可點擊
- 適合首頁與模組入口

### 8.6 `RoundImage`

位置：`lib/core/widgets/round_image.dart`

作用：

- 統一圓形圖片顯示
- 用於首頁 owl、數字蘋果等

### 8.7 `ActivityCard`

位置：`lib/features/home/presentation/widgets/activity_card.dart`

作用：

- 首頁小型功能卡片
- 包含 icon、標題、背景色、陰影色、點擊事件

### 8.8 `ProgressBubbles`

位置：`lib/features/home/presentation/widgets/progress_bubbles.dart`

作用：

- 顯示 Animals / Numbers / Food 的學習進度
- 已訪問頁面會填色
- 陰影 offset 會依照進度變化

現況：

- widget 本身可運作
- 但首頁目前未啟用

### 8.9 `AnimalCard`

位置：`lib/features/animals/presentation/widgets/animal_card.dart`

作用：

- 單張動物學習卡
- 顯示圖像、名稱、兩個互動按鈕

### 8.10 `_NumberCard`

位置：`lib/features/numbers/presentation/numbers_screen.dart`

作用：

- 顯示數字、數量圖像與語音標籤
- 同時承擔 TTS 行為

### 8.11 `_FoodTile`

位置：`lib/features/food/presentation/food_screen.dart`

作用：

- 顯示單個食物圖片
- 附帶右下角語音按鈕

### 8.12 `_SectionTitle`

位置：`lib/features/settings/presentation/settings_screen.dart`

作用：

- 設定頁每個區塊標題
- 支援暗色模式下自動換成較亮顏色

### 8.13 `_Panel`

位置：`lib/features/settings/presentation/settings_screen.dart`

作用：

- 統一設定頁面區塊容器樣式

### 8.14 `_VolumeSlider`

位置：`lib/features/settings/presentation/settings_screen.dart`

作用：

- 封裝音量調整 UI
- 與 provider 連動

### 8.15 `_LanguageButton`

位置：`lib/features/settings/presentation/settings_screen.dart`

作用：

- 顯示語言選項
- 使用圓形卡片加上國旗資產
- 支援選中樣式

### 8.16 `ParentGate`

位置：`lib/features/settings/presentation/widgets/parent_gate.dart`

作用：

- 用簡單問題防止兒童誤觸家長功能
- 答對後顯示額外選項

---

## 9. 語系與內容製作分析

### 9.1 多語系架構

專案已具備完整的 Flutter l10n 基礎：

- `app_en.arb`
- `app_zh.arb`
- `AppLocalizations`

這代表文字內容可以正式走多語系流程，而不是散落在頁面內寫死。

### 9.2 目前優點

- 主頁文字已多數本地化
- bottom nav 已支援多語系標籤
- settings / animals / food / numbers 都已接上 l10n

### 9.3 目前缺口

- `TopAppBar` 的 `Little Learner` 為硬編碼
- `ProgressBubbles` 的 `Play:` 為硬編碼
- 動物擬聲詞 `Roar / Trumpet / Hum` 未語系化

---

## 10. 語音與互動製作分析

### 10.1 語音架構

目前語音已統一成單一路徑：

#### `SpeechService`

用於 Animals / Numbers / Food。

在 web 上透過 `speech_service_web.dart` 封裝瀏覽器 `speechSynthesis`，並根據目前語系選擇對應的 `lang` 與可用 voice。

### 10.2 優點

- 已完成基本朗讀功能
- 音量 slider 已能控制主要語音輸出
- 架構上已做出統一 service abstraction
- Numbers / Animals / Food 已共用同一套語音入口
- 語音語系已能跟隨 `languageControllerProvider`

### 10.3 風險與問題

- web speech 在不同瀏覽器發音品質不同
- 不同作業系統與瀏覽器可用的 voice 名稱、品質與數量不一致
- 動物擬聲詞等內容本身尚未完整語系化，因此切換繁中後仍可能說出英文擬聲字

### 10.4 已完成項目與後續方向

- 已完成：統一所有語音行為透過單一 `SpeechService` facade 管理
- 已完成：根據 `languageControllerProvider` 切換 `lang` 與 voice
- 若要高品質，可改用錄製音檔或雲端語音服務
- 若要更穩定的多語發音，可建立 voice fallback 規則或加入平台偵測

---

## 11. 如何修改這個專案

以下從實務維護角度說明。

### 11.1 如果要新增一個功能頁面

例如新增 Colors 頁面：

1. 在 `features/colors/` 建立畫面與元件
2. 在 `AppTab` 新增 tab
3. 在 `AppShell` 的 `_screenFor()` 補上頁面 mapping
4. 更新 bottom nav 顯示
5. 補上對應 l10n 文案

### 11.2 如果要修改配色

應優先改：

- `core/theme/app_colors.dart`
- `core/theme/app_theme.dart`

不要直接在每一頁大量硬改顏色，否則後續維護成本會變高。

### 11.3 如果要修改文案

應修改：

- `lib/l10n/app_en.arb`
- `lib/l10n/app_zh.arb`

再重新產生 l10n 檔案。

### 11.4 如果要修改卡片樣式

優先檢查：

- `TactileCard`
- `ActivityCard`
- `AnimalCard`
- `_FoodTile`

因為目前 UI 的「厚卡片風格」主要就是由這些元件建出來。

### 11.5 如果要修改設定頁語言區

主要在：

- `settings_screen.dart` 的 `_LanguageButton`
- `AppAssets.flagUs / flagTw`

若未來想完全對齊 Figma，建議把這區抽成獨立 widget 檔案。

### 11.6 如果要修改進度系統

需要一起看：

- `progress_tracker.dart`
- `progress_bubbles.dart`
- `navigation_controller.dart`
- `home_screen.dart`

尤其首頁目前把 `ProgressBubbles` 註解掉，這是現階段最直接的 UI 斷點。

---

## 12. 製作品質分析

### 12.1 做得好的地方

- 功能模組切分明確
- UI 風格一致
- 兒童向互動設計清楚
- 已支援 dark mode
- 已支援 i18n
- 已有基本語音互動
- 共用 widget 抽象程度合理

### 12.2 中期可改進的地方

- 持久化不足：語系、夜間模式、音量未儲存
- debug `print()` 仍存在
- 部分硬編碼文字尚未多語化
- musicVolume 尚未完成 UI 與實際播放功能
- 動物擬聲詞與部分語音內容尚未完全多語化

### 12.3 結構風險

- 部分私有 widget 仍寫在單一 screen 檔內，頁面變大時可讀性會下降
- settings 頁面的 widget 已開始變複雜，未來建議拆檔
- 多語 / 多平台 / TTS 若持續擴充，需建立更明確的 service layer

---

## 13. 建議修改清單

以下是最值得優先處理的修改項目。

### 高優先

1. 重新啟用首頁 `ProgressBubbles`
2. 移除 debug `print()`
3. 將硬編碼文字移入 l10n
4. 將語系、深色模式、音量寫入本地儲存
5. 補齊語音內容本身的多語文案

### 中優先

1. 完成 Music 音量功能
2. 將 Settings 拆分為多個 widgets 檔案
3. 統一語音服務實作
4. 讓 animals 的 sound 使用真正音效檔

### 低優先

1. 加入動畫與轉場
2. 增加更多學習模組
3. 針對平板 / 桌機做更細緻的響應式版型

---

## 14. 總結

Little Learners Academy 是一個結構清楚、視覺方向明確、兒童導向相當成功的 Flutter Web 專案。它的核心價值不在複雜功能，而在於：

- 用簡單清楚的頁面完成兒童學習互動
- 用鮮明色塊建立模組識別
- 用大按鈕、大圖片與語音降低使用門檻
- 用 Riverpod、主題系統與 l10n 建立可擴充基礎

如果以產品成熟度來看，這個專案目前已經有不錯的原型完成度，適合作為：

- 幼兒教育展示網站
- 教學互動 prototype
- 早期 MVP

若要再往上提升成更完整產品，下一步應集中在：

- 資料持久化
- 進度功能正式上線
- 語音一致性
- 設定頁整理
- 更完整的多語體驗

整體評價：

- 視覺表現：好
- 架構可維護性：中上
- 可擴充性：中上
- 兒童產品適配度：高
- 目前完成度：中高
