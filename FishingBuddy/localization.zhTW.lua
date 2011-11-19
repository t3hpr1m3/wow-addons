-- Translation for zhTW by Indra from Eastern.Stories an old old old TW mud. 06/20/2007
-- 在下只翻譯了FishingBuddy 的部份.
-- Outfitter 的部份留待能人接續, 個人習慣使用Itemrack
-- Translation for zhTW , WOW version 2.3.0	Fish Buddy EBA0.9.3i by Indra	 
-- Special thanks translating advice from "Whocare" on "bahamut" a gamer forum of influence in Taiwan 11/24/2007

-- Update translation for 0.9.7 beta3 05/03/2009
-- Translations added from CurseForge, machihchung and "zhTW"

FishingTranslations["zhTW"] = {
	NAME = "釣魚夥伴",

	DESCRIPTION1 = "繼續追蹤你釣過的魚",
	DESCRIPTION2 = "和管理你的釣魚裝備",

	-- Tab labels and tooltips
	LOCATIONS_INFO = "根據區域或是魚種顯示你曾經釣過的魚",
	LOCATIONS_TAB = "位置",
	OPTIONS_INFO = "設定 #NAME# 選項",
	OPTIONS_TAB = "選項",

	POINT = "點",
	POINTS = "點",

	BOBBER_NAME = "浮標",

	CAST = "施放",

-- 以下為/fb命令參數,勿更動		  
	HELP = "幫助",
	UPDATEDB = "更新資料庫",
-- 以上為/fb命令參數,勿更動	  

	OUTFITS = "裝備",
	ELAPSED = "經過",
	TOTAL = "總數",
	TOTALS = "總數",
	
	SCHOOL = "魚群",	 -- e.g. 'Oily Blackmouth School'
	FLOATING_WRECKAGE = "漂浮的垃圾堆",
	FLOATING_DEBRIS = "漂浮的殘骸",
	ELEM_WATER = "元素之水",
	OIL_SPILL = "油井",

	GOLD_COIN = "金幣",
	SILVER_COIN = "銀幣",
	COPPER_COIN = "銅幣",
	
	LAGER = "蘭姆西船長的淡啤酒&",

-- 以下為/fb命令參數,勿更動
	ADD = "添加",
	REPLACE = "更換",
	UPDATE = "更新",
	CURRENT = "目前",
	RESET = "重置",
	CHECK = "檢查",
	CLEANUP = "清理",
	NOW = "目前",
-- 以上為/fb命令參數,勿更動	  

	NOREALM = "未知伺服器",

-- 以下為/fb命令參數,勿更動
	WATCHER = "監控器",
	WATCHER_LOCK = "鎖定",
	WATCHER_UNLOCK = "解鎖",
	 
	WEEKLY = "每周",
	HOURLY = "每小時",
-- 以上為/fb命令參數,勿更動		  
	
--	  BROADCAST_LABEL_TEXT = "視窗顯示";
--	  BROADCAST_DUMP_TEXT = "阻擋";
--	  BROADCAST_RECV_TEXT = "接受";

	OFFSET_LABEL_TEXT = "變換量:";

	KEYS_LABEL_TEXT = "輔助鍵：",
	KEYS_NONE_TEXT = "無",
	KEYS_SHIFT_TEXT = "Shift",		-- shift 鍵
	KEYS_CTRL_TEXT = "Control",	-- control 鍵
	KEYS_ALT_TEXT = "Alt",			-- alt 鍵	  

	SHOWFISHIES = "顯示魚",
	SHOWFISHIES_INFO = "根據魚種顯示漁獲歷史資訊",

	SHOWLOCATIONS = "位置",
	SHOWLOCATIONS_INFO = "根據區域顯示漁獲歷史資訊",

-- Option names and tooltips
	CONFIG_ALWAYSLURE_INFO	  = "If enabled, put a lure on every time the pole doesn't have one",	
	CONFIG_ALWAYSLURE_ONOFF	  = "Always Lure",
	CONFIG_AUTOLOOT_INFO		  = "勾選後, 釣到魚後自動從物品欄中拾取",
	CONFIG_AUTOLOOT_ONOFF	 = "自動拾取",
	CONFIG_BGSOUNDS_INFO		  = "勾選後,魔獸世界在背景執行時音效會被打開",
	CONFIG_BGSOUNDS_ONOFF	  = "背景音效",
	CONFIG_EASYCAST_INFO		 = "勾選後, 右鍵連點兩下拋竿",
	CONFIG_EASYCAST_ONOFF	 = "簡易拋竿",
	CONFIG_EASYLURES_INFO	 = "勾選後, 若魚竿未上餌, 拋竿時自動安裝魚餌",
	CONFIG_EASYLURES_ONOFF	 = "簡易上餌",
	CONFIG_ENHANCESOUNDS_INFO		  = "勾選後, 強化魚標跳動時減低低環境音效",
	CONFIG_ENHANCESOUNDS_ONOFF		  = "增強釣魚音效",
	CONFIG_FINDFISH_INFO		  = "勾選後,換上釣魚裝備時自動開啟「尋找魚點」技能",
	CONFIG_FINDFISH_ONOFF	  = "尋找魚點",
	CONFIG_FISHWATCHONLY_INFO	 = "只有在釣魚(手持釣竿)時開啟魚獲監視視窗",
	CONFIG_FISHWATCHONLY_ONOFF		= "釣魚時開啟",
	CONFIG_FISHWATCHPERCENT_INFO	 = "顯示該魚種占總魚獲的百分比",
	CONFIG_FISHWATCHPERCENT_ONOFF = "顯示百分比",
	CONFIG_FISHWATCHSKILL_INFO	 = "在監視器上顯示你目前釣魚技能及釣魚技能加成，括號內為技能要提升時(已經成功次數/估計所需的成功次數)",
	CONFIG_FISHWATCHSKILL_ONOFF = "當前技能",
	CONFIG_FISHWATCHTIME_INFO		= "顯示你拿起魚竿到現在經過的時間",
	CONFIG_FISHWATCHTIME_ONOFF		= "顯示經過時間",
	CONFIG_FISHWATCHZONE_INFO	 = "顯示所在漁場的區域及子區域名稱",
	CONFIG_FISHWATCHZONE_ONOFF		= "目前區域",
	CONFIG_FISHWATCH_INFO		 = "開啟該地點之魚獲監視視窗",
	CONFIG_FISHWATCH_ONOFF			= "魚獲監視器",
	CONFIG_MINIMAPBUTTON_INFO = "在小地圖顯示一個 #名稱# 的圖示",
	CONFIG_MINIMAPBUTTON_ONOFF = "顯示小地圖圖示",
	CONFIG_ONLYMINE_INFO		 = "勾選後,簡易拋竿功能將只會檢查玩家持用釣魚裝設定的魚竿,來決定是否拋竿",
	CONFIG_ONLYMINE_ONOFF	 = "僅用專用魚竿",
	CONFIG_OUTFITTER_TEXT		= "裝備技能加成: %s\r\nDraznar給的造型分數: %d ",	 
	CONFIG_SHOWLOCATIONZONES_INFO = "顯示區域和副區域。",
	CONFIG_SHOWLOCATIONZONES_ONOFF = "顯示區域",
	CONFIG_SHOWNEWFISHIES_INFO		= "在交談視窗顯示該地點之新魚獲",
	CONFIG_SHOWNEWFISHIES_ONOFF = "顯示新的魚",
	CONFIG_SORTBYPERCENT_INFO = "依照釣到的魚的數量排序顯示替代名稱排序。",
	CONFIG_SORTBYPERCENT_ONOFF = "依照數量分類",
	CONFIG_STVPOOLSONLY_INFO	 = "勾選後, 游標在魚群上才會進行自動拋竿",
	CONFIG_STVPOOLSONLY_ONOFF = "僅在魚群自動拋竿",
	CONFIG_STVTIMER_INFO		 = "勾選後, 顯示釣魚大賽計時及截止時間倒數",
	CONFIG_STVTIMER_ONOFF		= "釣魚大賽計時器",
	CONFIG_TOOLTIPS_INFO		  = "勾選後, 物品提示中會顯示該魚種的魚獲資訊",
	CONFIG_TOOLTIPS_ONOFF	 = "物品提示顯示釣魚資訊",
	CONFIG_TURNOFFPVP_INFO	  = "勾選後,當裝備魚竿時會關閉PVP(仍需要時間消除PVP標記)",
	CONFIG_TURNOFFPVP_ONOFF	  = "關閉PVP",
	CONFIG_USEACTION_INFO	 = "勾選後, #NAME# 將使用快捷列上的按鍵拋竿",
	CONFIG_USEACTION_ONOFF	 = "使用快捷列",

	CLICKTOSWITCH_ONOFF			  = "點擊切換",
	CLICKTOSWITCH_INFO			  = "勾選後,按左鍵點擊切換釣魚裝;未勾選則打開#NAME#視窗",	
		
	LEFTCLICKTODRAG = "左鍵點選拖曳",
	RIGHTCLICKFORMENU = "右鍵點選開啟選單",

	MINIMAPBUTTONPLACEMENT = "放置",
	MINIMAPBUTTONPLACEMENTTOOLTIP = "允許你在小地圖旁移動 #NAME# 圖示",
	MINIMAPBUTTONRADIUS = "距離",
	MINIMAPBUTTONRADIUSTOOLTIP = "決定 #NAME#小地圖圖示距離中心的距離",

	HIDEINWATCHER = "在監看中顯示此魚",	
	
	-- messages
	COMPATIBLE_SWITCHER = "無相容套裝切換",
	TOOMANYFISHERMEN = "你安裝了不只一個自動拋竿模組",
	FAILEDINIT = "初始化不正常",
	ADDFISHIEMSG = "添加 %s 到 %s 地區。",
	ADDSCHOOLMSG = "添加 '%s' 到 %s 地區。",
	NODATAMSG = "沒有可用的漁獲資料",
	CLEANUP_NONEMSG = "無舊設定遺留。",
	CLEANUP_WILLMSG = "舊設定遺留 |c#RED#%s|r: %s.",
	CLEANUP_DONEMSG = "已移除舊的設定 |c#RED#%s|r: %s。",
	CLEANUP_NOOLDMSG = "沒有舊的玩家設定 |c#GREEN#%s|r.",
	NONEAVAILABLE_MSG = "沒有可用的",
	UPDATEDB_MSG = "更新 %d 種魚名稱",	 

	MINIMUMSKILL = "最低所需技能： %d",
	NOTLINKABLE = "<物品無法連結>",
	CAUGHTTHISMANY = "捕獲:",
	CAUGHTTHISTOTAL = "總計:",
	FISHTYPES = "魚種： %d",
	CAUGHT_IN_ZONES = "捕獲在: %s",

	EXTRAVAGANZA = "釣魚大賽在",
	
	TIMER = "計時器",
	TIMETOGO = "%s開始於 %d:%02d",
	TIMELEFT = "%s結束於 %d:%02d",
	
	FATLADYSINGS = "|c#RED#%s 釣魚大賽已經過|r (剩餘時間 %d:%02d)",
	-- Figgle Bassbait yells: We have a winner! NAME is the Master Angler!	 
	RIGGLE_BASSBAIT = "^林格·巴斯貝特 .*: .*! (.*) .*!$",

	STVZONENAME = "荊棘谷",

	TOOLTIP_HINT = "提示：",
	TOOLTIP_HINTSWITCH = "點選來變換裝備",
	TOOLTIP_HINTTOGGLE = "點選來顯示 #NAME# 視窗",

	-- Key binding support
	BINDING_NAME_FISHINGBUDDY_TOGGLE = "切換 #NAME# 視窗",
	BINDING_NAME_FISHINGBUDDY_SWITCH = "切換釣魚套裝",
	BINDING_NAME_FISHINGBUDDY_GOFISHING = "換裝並釣魚",

	BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "切換 #NAME# 區域面板",
	BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "切換 #NAME# 選項面板",
	SWITCH_HELP = "|c#GREEN#/fb #SWITCH#|r#BRSPCS#穿/脫漁具 (如果有安裝OutfitDisplayFrame 或Outfitter的話)",
	WATCHER_HELP = "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r or |c#GREEN##WATCHER_UNLOCK#|r or |c#GREEN##RESET#|r]#BRSPCS#解鎖/鎖定/重置釣魚監視器的位置",
	CURRENT_HELP = "|c#GREEN#/fb #CURRENT# #RESET#|r#BRSPCS#重置這次釣魚期間的監視器記錄",
	UPDATEDB_HELP = "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r#BRSPCS#嘗試尋找所有我不知道的魚類名稱#BRSPCS#嘗試跳過 '稀有' 魚類可能會使你斷線#BRSPCS#-- '#FORCE#' 選項可以跳過檢測",
	CLEANUP_HELP = "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN##CHECK#|r or |c#GREEN##NOW#|r]#BRSPCS#清除舊設定, |c#GREEN##CHECK#|r 列出有哪些舊有#BRSPCS#的設定可以用 |c#GREEN##NOW#|r指令移除.",
	PRE_HELP = "你可以使用 |c#GREEN#/fishingbuddy|r 或 |c#GREEN#/fb|r 來執行所有命令#BR#|c#GREEN#/fb|r: 執行釣魚助手,開啟釣魚助手視窗#BR#|c#GREEN#/fb #HELP#|r: 顯示本協助畫面",
	POST_HELP = "你可以在\"選項\"的\"按鍵設定\"裡面設定開啟#NAME#視窗及切換釣魚裝的按鍵",
};
