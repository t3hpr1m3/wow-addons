--[[ Credit for these translations goes to:
	lsjyzjl
	szp1222
--]]
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "zhTW", false)
if not L then return end


L["ACTIVE"] = "%d 作用中"
L["AIR"] = "風之圖騰"
L["ALLOWCOMM"] = "允許圖示匯入"
L["ALLOWVERSIONWARN"] = "新版本通知"
L["ALPHA"] = "透明度"
L["ANN_CHANTOUSE"] = "使用頻道"
L["ANN_EDITBOX"] = "要輸出的文字內容"
L["ANN_EDITBOX_DESC"] = [=[輸入事件觸發時你想輸出的文字內容.

可以使用下列的單位變數:

%s

"%s" - 當前被檢查的法術/物品/等等
"%d" - 圖示計時器的剩餘時間
"%k" - 當前堆疊數量]=]
L["ANN_EDITBOX_WARN"] = "在此輸入你想要輸出的文字內容"
L["ANN_EVENT_GLOBALDESC"] = "在此列表中的事件是按照從上到下的順序來檢查.如果一個事件觸發並且輸出了文字內容,在它之後的事件將不再輸出任何文字內容."
L["ANN_SHOWICON"] = "顯示圖示材質"
L["ANN_SHOWICON_DESC"] = "一些文字目標能連同文字內容一起顯示一個材質.勾選此項啟用該功能."
L["ANN_STICKY"] = "靜態訊息"
L["ANN_SUB_CHANNEL"] = "輸出位置"
L["ANN_TAB"] = "文字輸出"
L["ANN_UNITSUBSTITUTIONS"] = [=["%t" - 目標的名字
"%f" - 專注目標的名字
"%m" - 滑鼠游標目標的名字
"%u" - 當前被檢查的單位的名字
"%s" - 當前被檢查的法術/物品/等的名字]=]
L["ANN_WHISPERTARGET"] = "悄悄話目標"
L["ANN_WHISPERTARGET_DESC"] = [=[輸入你想要密語的玩家名字, 僅可密語同伺服器/同陣營的玩家.可以使用下列的單位變數:

%s]=]
L["ASCENDING"] = "升序"
L["ASPECT"] = "守護"
L["AURA"] = "光環"
L["BleedDamageTaken"] = "受到的流血效果傷害提高"
L["Bleeding"] = "流血效果"
L["BonusAgiStr"] = "敏捷/力量提高"
L["BonusArmor"] = "護甲值提高"
L["BonusMana"] = "法力值上限提高"
L["BonusStamina"] = "耐力提高"
L["BOTTOM"] = "下"
L["BOTTOMLEFT"] = "左下"
L["BOTTOMRIGHT"] = "右下"
L["BUFFCNDT_DESC"] = [=[只有第一個法術會被檢查,其他的將全部被忽略.
輸入法術ID時不會強制跟它們對應的效果進行匹配,僅使用名稱時必須匹配.]=]
L["BUFFTOCHECK"] = "要檢查的增益"
L["BUFFTOCOMP1"] = "進行比較的第一個增益"
L["BUFFTOCOMP2"] = "進行比較的第二個增益"
L["BurstHaste"] = "英勇/嗜血"
L["BurstManaRegen"] = "突發性法力恢復"
L["CACHING"] = "TellMeWhen正在快取和篩選遊戲中的所有法術.這只需要在每次魔獸世界補丁升級之後完成一次.您可以使用下方的滑桿加快或減慢過程."
L["CACHINGSPEED"] = "法術快取速度(每幀法術):"
L["CASTERFORM"] = "施法者姿態"
L["CENTER"] = "中間"
L["CHAT_FRAME"] = "聊天視窗"
L["CHAT_MSG_CHANNEL"] = "聊天頻道"
L["CHAT_MSG_CHANNEL_DESC"] = "將輸出到一個聊天頻道,例如交易頻道或是你加入的某個自訂頻道."
L["CHAT_MSG_SMART"] = "智能頻道"
L["CHAT_MSG_SMART_DESC"] = "此頻道會自行選擇最合適的輸出頻道.(僅限於:戰場,團隊,隊伍,或者說)"
L["CHECKORDER"] = "更新排序"
L["CHECKORDER_GROUPDESC"] = "更改此項將會按照設定來更新此群組的排序.只會在你需要使用檢查 整合圖示 的子元時用到.(子元指添加到整合圖示列表中的整合圖示)"
L["CHECKORDER_ICONDESC"] = "勾選此項將會按照設定來更新此群組中的圖示的排序.只會在你需要使用檢查 整合圖示 的子元時用到.(子元指添加到整合圖示列表中的整合圖示)"
L["CHOOSENAME_DIALOG"] = [=[輸入你想讓此圖示監視的名稱或者ID,你可以利用分號';'輸入多個條目(名稱/ID/同類型的任意組合).

你可以按住Shift再按滑鼠左鍵點選法術/物品/聊天連結或者拖曳法術/物品添加到此編輯框中.]=]
L["CHOOSENAME_DIALOG_CNDTIC"] = "輸入你要使用的法術材質名稱或ID.你也可以輸入一個材質路徑,例如'Interface/Icons/spell_nature_healingtouch', 假如材質路徑為'Interface/Icons'可以只輸入'spell_nature_healingtouch'."
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "預設法術/驱散类型"
L["CHOOSENAME_DIALOG_MSCD"] = "輸入你要此圖示監視的名稱或者ID,僅第一個法術/物品會被檢查,使用分號分隔的列表不適用此圖示類型."
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959寵物技能|r必須使用法術ID."
L["CHOOSENAME_EQUIVS_TOOLTIP"] = "你可以在此選單中選擇預設的增益/減益,法術施放,遞減,或者驅散類型(魔法,詛咒等.)插入到\"%s\"編輯框中."
L["CMD_OPTIONS"] = "選項"
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "玩家屬性/狀態"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "單位屬性/狀態"
L["CNDTCAT_BUFFSDEBUFFS"] = "增益/減益"
L["CNDTCAT_CURRENCIES"] = "通貨"
L["CNDTCAT_FREQUENTLYUSED"] = "常用條件"
L["CNDTCAT_RESOURCES"] = "能量類型"
L["CNDTCAT_SPELLSABILITIES"] = "法術/物品"
L["CNDTCAT_STATS"] = "戰鬥統計(人物屬性)"
L["CNDT_ONLYFIRST"] = "僅檢查第一個法術/物品,使用分號分隔的列表不適用此條件類型."
L["CODETOEXE"] = "要執行的代碼"
L["COLOR_CBC"] = "冷卻條 - 完成"
L["COLOR_CBC_DESC"] = "冷卻/持續時間計量條在冷卻/持續時間已完成後的顏色"
L["COLOR_CBS"] = "冷卻條 - 開始"
L["COLOR_CBS_DESC"] = "冷卻/持續時間計量條在冷卻/持續時間剛開始的顏色"
L["COLOR_COA"] = "倒數中,計時器隱藏,一直顯示"
L["COLOR_COA_DESC"] = [=[圖示在何時著色:

計時器激活(不可用/存在時),
%q已禁用
%q設定為%q]=]
L["COLOR_COLOR"] = "顏色"
L["COLOR_COS"] = "倒數中,計時器隱藏,有時顯示"
L["COLOR_COS_DESC"] = [=[圖示在何時著色:

計時器激活(不可用/存在時),
%q已禁用
%q沒有設定為%q]=]
L["COLOR_CTA"] = "倒數中,計時器顯示,一直顯示"
L["COLOR_CTA_DESC"] = [=[圖示在何時著色:

計時器激活(不可用/存在時),
%q已啟用
%q設定為%q]=]
L["COLOR_CTS"] = "倒數中,計時器顯示,有時顯示"
L["COLOR_CTS_DESC"] = [=[圖示在何時著色:

計時器激活(不可用/存在時),
%q已啟用
%q沒有設定為%q]=]
L["COLOR_DEFAULT"] = "*全局顏色*"
L["COLOR_DESATURATE"] = "灰色調"
L["COLOR_DESATURATE_DESC"] = "勾選此項圖示中相關的顏色將使用灰色調.(注意:需要先勾選顏色類型的'使用'選項)"
L["COLOR_HEADER"] = [=[下列這些顏色設定將使用在所有%s 的圖示上,在它們的選項%q 已勾選的情況下.

純白色不會對材質造成任何改變. 純黑色會使材質完全變黑.所有介於黑白兩者之間的灰色調及其他顏色全部都會對圖示進行著色.]=]
L["COLOR_HEADER_DEFAULT"] = [=[在圖示類型沒有單獨使用顏色設定的時候將使用這些顏色設定.

純白色不會對材質造成任何改變. 純黑色會使材質完全變黑.所有介於黑白兩者之間的灰色調及其他顏色全部都會對圖示進行著色.]=]
L["COLOR_NA"] = "已結束,一直顯示"
L["COLOR_NA_DESC"] = [=[圖示在何時著色:

計時器已結束(可用/缺少時),
%q設定為%q]=]
L["COLOR_NS"] = "已結束,有時顯示"
L["COLOR_NS_DESC"] = [=[圖示在何時著色:

計時器已結束(可用/缺少時)
%q沒有設置為%q]=]
L["COLOR_OOM"] = "法力值不足"
L["COLOR_OOM_DESC"] = "當你施放法術能量不足時圖示的顏色."
L["COLOR_OOR"] = "超出距離"
L["COLOR_OOR_DESC"] = "當你不在技能範圍內時圖示的顏色."
L["COLOR_OORM"] = "超出距離&法力值不足"
L["COLOR_OORM_DESC"] = "當你施放法術能量不足 同時 不在技能範圍內時圖示的顏色"
L["COLOR_OVERRIDEDEFAULT"] = "使用"
L["COLOR_OVERRIDEDEFAULT_DESC"] = "勾選此項將使用該設定覆蓋*全局顏色*."
L["COLOR_RESET_DESC"] = "點擊將此設定重設為預設值"
L["COMPARISON"] = "比較"
L["CONDITIONALPHA"] = "持續時間/堆疊/條件未通過時"
L["CONDITIONALPHA_CONDITIONICON"] = "持續時間未通過時"
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "此透明度設定用於持續時間的要求無法得到滿足時.如果在其它兩個透明度的設定下圖示已經隱藏,此選項將被忽略."
L["CONDITIONALPHA_DESC"] = "此透明度設定用於條件未通過或者持續時間/堆疊數量的要求無法得到滿足時.如果在其它兩個透明度的設定下圖示已經隱藏,此選項將被忽略."
L["CONDITIONORMETA_CHECKINGINVALID"] = "警告!群組 %d,圖示 %d 正在檢查一個無效的圖示(群組 %d , 圖示 %d)"
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "警告! 群組 %d 正在檢查一個無效的圖示 (群組 %d, 圖示 %d)"
L["CONDITIONPANEL_ABSOLUTE"] = "當前"
L["CONDITIONPANEL_ADD"] = "新增條件"
L["CONDITIONPANEL_ALIVE"] = "單位存活"
L["CONDITIONPANEL_ALIVE_DESC"] = "此條件會在單位還活著時通過"
L["CONDITIONPANEL_ALTPOWER"] = "特殊能量"
L["CONDITIONPANEL_ALTPOWER_DESC"] = "這是浩劫與重生某些首領戰遇到的特殊能量,像是丘加利的腐化值跟亞特拉米德的音波值."
L["CONDITIONPANEL_AND"] = "同時"
L["CONDITIONPANEL_ANDOR"] = "同時/或者"
L["CONDITIONPANEL_ANDOR_DESC"] = "點擊切換邏輯運算符 同時/或者(And/Or)"
L["CONDITIONPANEL_AUTOCAST"] = "寵物自動施法"
L["CONDITIONPANEL_CASTTOMATCH"] = "用於匹配的法術"
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = [=[在此輸入一個法術名稱使該條件只在施放的法術名稱跟輸入的法術名稱完全匹配時才可通過.

你可以保留空白來檢查任意的法術施放/引導法術(不包括瞬發法術).]=]
L["CONDITIONPANEL_CLASS"] = "單位職業"
L["CONDITIONPANEL_CLASSIFICATION"] = "單位分類"
L["CONDITIONPANEL_COMBAT"] = "單位在戰鬥中"
L["CONDITIONPANEL_COMBO"] = "連擊點數"
L["CONDITIONPANEL_DEFAULT"] = "選擇條件類型..."
L["CONDITIONPANEL_ECLIPSE_DESC"] = [=[蝕星蔽月有一個範圍在-100(月蝕) 到100(日蝕). 
如果你想讓圖示在有80月蝕的時候顯示請輸入-80]=]
L["CONDITIONPANEL_EQUALS"] = "等於"
L["CONDITIONPANEL_EXISTS"] = "單位存在"
L["CONDITIONPANEL_GREATER"] = "大於"
L["CONDITIONPANEL_GREATEREQUAL"] = "大於或者等於"
L["CONDITIONPANEL_GROUPTYPE"] = "隊伍類型"
L["CONDITIONPANEL_ICON"] = "圖示顯示"
L["CONDITIONPANEL_ICON_DESC"] = [=[此條件檢查指定圖示的顯示狀態或隱藏狀態.

如果你不想顯示那個被檢查的圖示,請在被檢查圖示的圖示編輯器勾選 %q.

即使條件設定為否,同樣會強制檢查圖示的顯示情況.]=]
L["CONDITIONPANEL_ICON_HIDDEN"] = "隱藏"
L["CONDITIONPANEL_ICON_SHOWN"] = "顯示"
L["CONDITIONPANEL_INSTANCETYPE"] = "副本類型"
L["CONDITIONPANEL_INTERRUPTIBLE"] = "可斷法"
L["CONDITIONPANEL_ITEMRANGE"] = "單位在物品範圍內"
L["CONDITIONPANEL_LESS"] = "小於"
L["CONDITIONPANEL_LESSEQUAL"] = "小於或者等於"
L["CONDITIONPANEL_LEVEL"] = "單位等級"
L["CONDITIONPANEL_MANAUSABLE"] = "法術可用(法力值/能量/等是否夠用)"
L["CONDITIONPANEL_MAX"] = "最大"
L["CONDITIONPANEL_MOUNTED"] = "在坐騎上"
L["CONDITIONPANEL_NAME"] = "單位名字"
L["CONDITIONPANEL_NAMETOMATCH"] = "用於匹配的名字"
L["CONDITIONPANEL_NAMETOOLTIP"] = "你可以在每個名字後面加上分號(;)以便輸入多個需要匹配的名字. 其中任何一個名字匹配時此條件都會通過."
L["CONDITIONPANEL_NOTEQUAL"] = "不等於"
L["CONDITIONPANEL_OPERATOR"] = "運算"
L["CONDITIONPANEL_OR"] = "或者"
L["CONDITIONPANEL_PETMODE"] = "寵物攻擊模式"
L["CONDITIONPANEL_PETTREE"] = "寵物天賦樹"
L["CONDITIONPANEL_POWER"] = "基本資源"
L["CONDITIONPANEL_POWER_DESC"] = "檢查單位為德魯伊時在貓形態的能量,或者單位為戰士時的怒氣等等."
L["CONDITIONPANEL_PVPFLAG"] = "開啟PVP的單位"
L["CONDITIONPANEL_RAIDICON"] = "單位團隊標記"
L["CONDITIONPANEL_REMOVE"] = "移除此條件"
L["CONDITIONPANEL_RESTING"] = "休息狀態"
L["CONDITIONPANEL_ROLE"] = "單位角色類型"
L["CONDITIONPANEL_RUNES_DESC"] = [=[使用此條件類型讓圖示只在選擇的符文可用時顯示圖示.
每個符文都可以複選.一個複選標記會要求符文是可用的,一個'X'會要求符文是不可用的,沒標記將會忽略這個符文.
第二行符文為上面每個符文所對應的死亡符文.]=]
L["CONDITIONPANEL_SPELLRANGE"] = "單位在法術範圍內"
L["CONDITIONPANEL_SWIMMING"] = "游泳狀態"
L["CONDITIONPANEL_THREAT_RAW"] = "單位威脅值 - 原始"
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [=[此條件用來檢查你對一個單位的原始威脅值百分比.

近戰玩家仇恨失控(OT)的威脅值為110%
遠程玩家仇恨失控(OT)的威脅值為130%]=]
L["CONDITIONPANEL_THREAT_SCALED"] = "單位威脅值 - 比例"
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [=[此條件用來檢查你對一個單位的威脅值百分比比例.

100%表示你正在坦這個單位.]=]
L["CONDITIONPANEL_TRACKING"] = "追蹤"
L["CONDITIONPANEL_TYPE"] = "類型"
L["CONDITIONPANEL_UNIT"] = "單位"
L["CONDITIONPANEL_UNIT_DESC"] = [=[在此輸入需要監視的單位.此單位能從下拉列表插入到右邊,或者你是一位高端玩家可以自行輸入需要監視的單位.
可使用標準單位(例如:player,target,mouseover,等) 或者友好玩家的名字(例如: %s, Cybeloras,小兔是豬,阿光是豬,等.)
PS:上面的標準單位不是沒有翻譯,巨集中可以使用的單位都可以使用.]=]
L["CONDITIONPANEL_UNITDROPDOWN_DESC"] = [=[您可以從此選單中選擇單位插入到編輯框中.
單位的結尾'|cFFFF0000#|r'需要替換為單位相對應的數字.
例如更改'raid|cFFFF0000#|r'為'raid25'檢查第25個團隊成員.

注意:所有條件只允許檢查一個單位.]=]
L["CONDITIONPANEL_UNITISUNIT"] = "單位比較"
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "此條件在兩個編輯框輸入的單位為同一角色時通過.(例子:編輯框1為'targettarget',編輯框2為'player',當'目標的目標'為'玩家'時此條件通過.)"
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "在此編輯框輸入需要與所指定的第一單位進行比較的第二單位."
L["CONDITIONPANEL_VALUEN"] = "值"
L["CONDITIONPANEL_VEHICLE"] = "單位控制載具"
L["CONDITIONS"] = "條件"
L["CONDITION_TIMERS_FAIL_DESC"] = [=[設定條件無法通過以後圖示計時器的持續時間

(譯者註:圖示在條件每次通過/無法通過後都會重新計時,另外在默認的情況下圖示的顯示只會根據條件通過情況來改變,設定的持續時間不會影響到圖示的顯示情況,不會在設定的持續時間倒數結束後隱藏圖示,如果想要圖示在計時結束後隱藏,需要勾選'僅在計時器作用時顯示',這是4.5.3版本新加入的功能.)]=]
L["CONDITION_TIMERS_HEADER"] = "計時器"
L["CONDITION_TIMERS_SUCCEED_DESC"] = [=[設定條件成功通過以後圖示計時器的持續時間

(譯者註:圖示在條件每次通過/無法通過後都會重新計時,另外在默認的情況下圖示的顯示只會根據條件通過情況來改變,設定的持續時間不會影響到圖示的顯示情況,不會在設定的持續時間倒數結束後隱藏圖示,如果想要圖示在計時結束後隱藏,需要勾選'僅在計時器作用時顯示',這是4.5.3版本新加入的功能.)]=]
L["CONFIGMODE"] = "TellMeWhen正處於設定模式. 在離開設定模式之前,圖示無法正常使用. 輸入'/tellmewhen'或'/tmw'可以開啟或關閉設定模式."
L["CONFIGMODE_EXIT"] = "退出設定模式"
L["CONFIGMODE_NEVERSHOW"] = "不再顯示此訊息"
L["CONFIRMOVERWRITE"] = "確認覆蓋"
L["COPYGROUP"] = "複製群組"
L["COPYPOSSCALE"] = "複製位置/比例"
L["CrowdControl"] = "控場技能"
L["Curse"] = "詛咒"
L["DamageBuffs"] = "傷害爆發增益"
L["DAMAGER"] = "傷害輸出"
L["DEBUFFTOCHECK"] = "要檢查的減益"
L["DEBUFFTOCOMP1"] = "進行比較的第一個減益"
L["DEBUFFTOCOMP2"] = "進行比較的第二個減益"
L["DEFAULT"] = "預設值"
L["DefensiveBuffs"] = "防禦性增益"
L["DESCENDING"] = "降序"
L["DISABLED"] = "已停用"
L["Disarmed"] = "繳械"
L["Disease"] = "疾病"
L["Disoriented"] = "困惑"
L["DR-Banish"] = "放逐術"
L["DR-ControlledRoot"] = "控制定身"
L["DR-ControlledStun"] = "控制擊暈"
L["DR-Cyclone"] = "颶風術"
L["DR-Disarm"] = "繳械"
L["DR-Disorient"] = "迷惑/其它"
L["DR-DragonsBreath"] = "龍之吐息"
L["DR-Entrapment"] = "誘捕"
L["DR-Fear"] = "恐懼"
L["DR-Horrify"] = "恐慌"
L["DR-MindControl"] = "精神控制"
L["DROPDOWN_UNIT_DESC"] = [=[您可以從這個選單中選擇單位插入到編輯框中.
單位結尾'|cFFFF0000#|r'需要替換為單位相對應的數字,或者輸入某個範圍的數字,像是1-10.
例如更改'raid|cFFFF0000#|r'為'raid25' 檢查第25個團隊成員,或者把它改成'raid1-25'檢查前25個團隊成員.

需要更多關於單位的資訊,請訪問http://www.wowpedia.org/UnitId]=]
L["DR-RandomRoot"] = "隨機定身"
L["DR-RandomStun"] = "隨機擊暈"
L["DR-Scatter"] = "驅散射擊"
L["DR-Silence"] = "沉默"
L["DR-Taunt"] = "嘲諷"
L["DURATION"] = "持續時間"
L["DURATIONPANEL_TITLE"] = "持續時間"
L["EARTH"] = "大地圖騰"
L["ECLIPSE_DIRECTION"] = "蝕星蔽月方向"
L["elite"] = "精英"
L["ENABLINGOPT"] = "TellMeWhen選項已停用.正在重新啟用中..."
L["Enraged"] = "狂暴"
L["ERROR_ANCHORSELF"] = "%s嘗試依附於它自己,所以TellMeWhen會重設它的依附位置到螢幕中間以防止出現嚴重的錯誤."
L["ERROR_MISSINGFILE"] = "TellMeWhen需要在重開魔獸世界之後才能正常使用 %s (原因:無法找到%s). 你要馬上重開魔獸世界嗎?"
L["ERROR_MISSINGFILE_NOREQ"] = "TellMeWhen需要在重開魔獸世界之後才能完全正常使用 %s (原因:無法找到%s). 你要馬上重開魔獸世界嗎?"
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "僅在條件剛通過時"
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "除非上面設置的條件剛剛成功通過,否則阻止事件的觸發."
L["EVENTS_SETTINGS_GLOBAL_DESC"] = "注意:此事件設定將影響到包括'音效'和'文字輸出'在內的所有與該設定相關的輸出事件."
L["EVENTS_SETTINGS_HEADER"] = "事件設定"
L["EVENTS_SETTINGS_ONLYSHOWN"] = "僅在圖示顯示時觸發"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "勾選此項防止圖示在沒有顯示時觸發相關事件."
L["EVENTS_SETTINGS_PASSINGCNDT"] = "僅在條件通過時觸發:"
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "除非下面設置的條件成功通過,否則阻止事件的觸發."
L["EVENTS_SETTINGS_PASSTHROUGH"] = "允許觸發其他事件"
L["EVENTS_SETTINGS_PASSTHROUGH_DESC"] = [=[允許在觸發該事件後去觸發另一個事件,如果取消勾選,在該事件觸發並輸出了文字/音效之後,圖示不再處理同時觸發的其它任何事件.

可以有例外,詳情請參閱個別事件的描述.]=]
L["EXPORT_f"] = "匯出 %s"
L["EXPORT_HEADING"] = "匯出"
L["EXPORT_SPECIALDESC"] = "另一TellMeWhen使用者需要安裝4.6.0+的版本才可以匯入整個群組或整個設定檔."
L["EXPORT_TOCOMM"] = "到玩家"
L["EXPORT_TOCOMM_DESC"] = "輸入一個玩家的名字到編輯框同時選擇此選項來發送數據給他們.他們必須是你能密語的某人(同陣營,同伺服器,在線),同時他們必須已經安裝版本為4.0.0+的TellMeWhen."
L["EXPORT_TOSTRING"] = "到字串"
L["EXPORT_TOSTRING_DESC"] = "包含必要數據的字串將匯出到編輯框裡,按下CTRL+C複製它,然後到任何你想分享的地方貼上它."
L["FALSE"] = "否"
L["Feared"] = "恐懼"
L["fGROUP"] = "群組: %s"
L["fICON"] = "圖示: %s"
L["FIRE"] = "火焰圖騰"
L["FONTCOLOR"] = "文字顏色"
L["FONTSIZE"] = "字體大小"
L["fPROFILE"] = "設定檔: %s"
L["FROMNEWERVERSION"] = "你匯入的數據是版本較新的TellMeWhen所創建的.某些設定在你更新至最新版本之前可能無法正常使用."
L["GCD"] = "公共冷卻"
L["GCD_ACTIVE"] = "公共CD作用中"
L["GENERIC_NUMREQ_CHECK_DESC"] = "勾選以啟用並配置%s"
L["GROUPADDONSETTINGS"] = "群組設定"
L["GROUPCONDITIONS"] = "群組條件"
L["GROUPICON"] = "群組: %s, 圖示: %s"
L["HEALER"] = "治療"
L["Heals"] = "玩家治疗法术"
L["HELP_EXPORT_DOCOPY_MAC"] = "按下|cff7fffffCMD+C|r複製"
L["HELP_EXPORT_DOCOPY_WIN"] = "按下|cff7fffffCTRL+C|r複製"
L["HELP_FIRSTUCD"] = [=[這是你第一次使用一個採取特定的持續時間語法的圖示類型!
在添加法術到某些圖示類型的 %q 編輯框時,必須使用下列語法在法術後面指定它們的持續時間:

法術:持續時間

例如:

"%s: 120"
"%s: 10; %s: 24"
"%s: 180"
"%s: 3:00"
"62618: 3:00"

用建議列表插入條目時會自動添加在滑鼠提示資訊中顯示的時間(僅支持提示資訊中顯示的冷卻時間).]=]
L["HELP_ICD_NATURESGRACE"] = [=[您是否嘗試檢查 %s 的內置冷卻? 

建議您將圖示類型更改為%q , 可以在日蝕或月蝕觸發之後正確重置自然之賜的冷卻時間. ]=]
L["HELP_IMPORT_CURRENTPROFILE"] = [=[嘗試在這個設定檔中移動或複制一個圖示到另外一個圖示欄位?

你可以輕鬆的做到這一點,使用滑鼠右鍵點擊圖示並拖曳它到另外一個圖示欄位(這個過程需要按下滑鼠右鍵不放開). 當你放開滑鼠右鍵時,會出現一個有很多選項的選單.

嘗試拖曳一個圖示到整合圖示,其他群組,或在你螢幕上的其他框體以獲取其他相應的選項.]=]
L["HELP_MISSINGDURS"] = [=[以下法術缺少持續時間:

%s

請使用下列語法添加持續時間:

法術:持續時間

例如 "%s: 10"

用建議列表插入條目時會自動添加在滑鼠提示資訊中顯示的時間(僅支持提示資訊中顯示的冷卻時間).]=]
L["HELP_MS_NOFOUND"] = [=[無法在動作條上找到技能 %q. 

請確保那個技能在你的動作條上,並且它是處於默認狀態,必須要注意的是出現在動作條上的技能不能是一個巨集,而是應該直接把技能放到你的動作條上.否則此圖示可能無法正常使用. 

上述默認狀態指沒有施放該技能使其出現第二個狀態.]=]
L["HELP_NOUNIT"] = "你必須輸入一個單位!"
L["HELP_NOUNITS"] = "你至少需要輸入一個單位!"
L["HELP_POCKETWATCH"] = [=[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t -- 關於懷錶材質

此材質用於第一個檢測到的有效法術在你的法術書中不存在時.

正確的材質將會在你施放過一次或者見到過一次該法術之後使用.

若要顯示正確的材質,請把第一個被檢查的法術名稱更改為法術ID.你可以輕鬆的做到這一點,你只需要點擊名稱編輯框中的法術,再根據之後出現的建議列表中顯示的正確的以及相對應的法術上點擊滑鼠右鍵即可.

(這裡的法術指排在首位的法術,當你的滑鼠移動到建議列表的某個法術上時,在提示資訊中可以看到更為具體的 滑鼠左右鍵插入法術ID或法術名稱的方法.)]=]
L["ICON"] = "圖示"
L["ICONALPHAPANEL_FAKEHIDDEN"] = "總是隱藏"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = "使該圖示一直被隱藏,但圖示依然會處理並執行音效跟文字輸出,而且仍然可以讓包含此圖示的條件或整合圖示來檢查它."
L["ICONGROUP"] = "圖示: %s (群組: %s)"
L["ICONMENU_ABSENT"] = "缺少時"
L["ICONMENU_ADDMETA"] = "添加到'整合圖示'"
L["ICONMENU_ALPHA"] = "透明度"
L["ICONMENU_ALWAYS"] = "一直顯示"
L["ICONMENU_ANCHORTO"] = "依附於 %s"
L["ICONMENU_ANCHORTO_DESC"] = [=[依附%s於%s,無論%s如何移動,%s都會跟隨它一起移動.

群組選項中有進階依附設定.]=]
L["ICONMENU_ANCHORTO_UIPARENT"] = "重設依附"
L["ICONMENU_ANCHORTO_UIPARENT_DESC"] = [=[讓%s重新依附於你的螢幕(UIParent). 它目前依附於%s.

群組選項中有進階依附設定.]=]
L["ICONMENU_APPENDCONDT"] = "添加到'圖示顯示'條件"
L["ICONMENU_BAROFFS"] = [=[此數值將會添加到計量條以便用來調整它的位移值.

一些有用的例子:
當你開始施法時防止一個增益消失的自訂指示器,或者用來指示某個法術施放所需能量的同時還剩多少時間可以打斷施法.]=]
L["ICONMENU_BINDTEXT_DESC"] = [=[在此編輯框中的任意文字將以動作條上顯示的按鍵綁定文字的方式顯示在圖示上.這並非設定TellMeWhen圖示的按鍵綁定!它只是一個顯示在圖示上的文字提示的視覺效果.在本群組的'群組設定'中可以更改此文字的設定.

自訂顯示文字可以使用下列的單位變數:

"%u" - 當前被檢查的單位的名字
"%s" - 當前被檢查的法術/物品/等的名字]=]
L["ICONMENU_BOTH"] = "任意一種"
L["ICONMENU_BUFF"] = "增益"
L["ICONMENU_BUFFDEBUFF"] = "增益/減益"
L["ICONMENU_BUFFDEBUFF_DESC"] = "檢查增益或減益."
L["ICONMENU_BUFFTYPE"] = "增益或減益"
L["ICONMENU_CAST"] = "法術施放"
L["ICONMENU_CAST_DESC"] = "檢查非瞬發施法和引導法術."
L["ICONMENU_CASTS"] = "法術施放"
L["ICONMENU_CASTSHOWWHEN"] = "何時顯示法術施放"
L["ICONMENU_CHECKNEXT"] = "檢查子元(用於列表中包含整合圖示)"
L["ICONMENU_CHECKNEXT_DESC"] = [=[選中此框該圖示將檢查添加在列表中的任意整合圖示所包含的全部圖示,它可能是任何級別的檢查.

此外,該圖示不會顯示已經在另一個整合圖示顯示的任何群組/圖示ID接近1的圖示.]=]
L["ICONMENU_CHECKREFRESH"] = "法術刷新偵測"
L["ICONMENU_CHECKREFRESH_DESC"] = [=[暴雪的戰鬥記錄在涉及法術刷新和恐懼(或者某些在造成一定傷害量後才會中斷的法術)存在嚴重缺陷,戰鬥記錄會認為法術在造成傷害時已經刷新,儘管事實上並非如此.

取消此選項以便停用法術刷新偵測,注意:正常的刷新也將被忽略. 

如果你檢查的遞減在造成一定傷害量後不會中斷的話建議保留此選項.]=]
L["ICONMENU_CHOOSENAME"] = "選擇用於檢查的名稱/ID"
L["ICONMENU_CHOOSENAME_CNDTIC"] = "選擇 法術名稱/ID/材質路徑"
L["ICONMENU_CHOOSENAME_ITEMSLOT"] = "選擇用於檢查的 名稱/ ID / 裝備欄位編號(%d-%d)"
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[輸入你想要此圖示監視的名稱/ID/裝備欄位編號. 你可以利用分號添加多個條目(名稱/ID/裝備欄位編號的任意組合).

裝備欄位編號是已裝備物品所在欄位的編號索引.如果你更換了那個裝備欄位的已裝備物品,將不會影響圖示的正常使用並且在圖示上會立刻反映出來.

你可以按住Shift再按滑鼠左鍵點選物品/聊天連結或者拖曳物品添加到此編輯框中.]=]
L["ICONMENU_CHOOSENAME_MULTISTATE"] = "選擇用於檢查的 名稱/ID"
L["ICONMENU_CHOOSENAME_ORBLANK"] = "或者保留空白檢查所有"
L["ICONMENU_CHOOSENAME_WPNENCH"] = "用於檢查的附魔"
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[輸入你想要此圖示監視的暫時性武器附魔的名稱. 你可以利用分號(;)添加多個條目.

|cFFFF5959重要提示|r: 附魔名稱必須使用在暫時性武器附魔激活時出現在武器的提示資訊中的那個名稱(例如:'磨利(+6傷害)', 而不是'堅固的磨刀石' ).]=]
L["ICONMENU_CNDTIC"] = "條件圖示"
L["ICONMENU_CNDTIC_DESC"] = "檢查條件的狀態."
L["ICONMENU_CNDTSHOWWHEN"] = "當條件怎樣時顯示"
L["ICONMENU_COMPONENTICONS"] = "元件圖示&群組"
L["ICONMENU_COOLDOWNCHECK"] = "冷卻檢查"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "勾選此項啟用當可用技能在冷卻中時視為不可用."
L["ICONMENU_COOLDOWNTYPE"] = "冷卻類型"
L["ICONMENU_COPYHERE"] = "複製到此"
L["ICONMENU_CUSTOMTEX"] = "自訂圖示材質"
L["ICONMENU_CUSTOMTEX_DESC"] = [=[如果你要更改此圖示顯示的材質, 輸入你想使用的材質的法術名稱或ID. 
你也可以輸入一個材質路徑,例如'Interface/Icons/spell_nature_healingtouch', 假如材質路徑為'Interface/Icons'可以只輸入'spell_nature_healingtouch'.]=]
L["ICONMENU_DEBUFF"] = "減益"
L["ICONMENU_DISPEL"] = "驅散類型"
L["ICONMENU_DONTREFRESH"] = "不刷新"
L["ICONMENU_DONTREFRESH_DESC"] = [=[勾選此項當效果觸發時它仍然在倒計時則不重置冷卻時間.
在類似法師的早霜等天賦會用到.]=]
L["ICONMENU_DR"] = "遞減"
L["ICONMENU_DRABSENT"] = "未遞減"
L["ICONMENU_DR_DESC"] = "檢查遞減程度跟遞減時間."
L["ICONMENU_DRPRESENT"] = "已遞減"
L["ICONMENU_DRS"] = "遞減"
L["ICONMENU_DURATION_MAX_DESC"] = "允許圖示顯示的最大持續時間,高於此數值圖示將被隱藏."
L["ICONMENU_DURATION_MIN_DESC"] = "顯示圖示所需的最小持續時間,低於此數值圖示將被隱藏."
L["ICONMENU_ENABLE"] = "啟用圖示"
L["ICONMENU_FAIL"] = "無法通過時"
L["ICONMENU_FOCUS"] = "專注目標"
L["ICONMENU_FOCUSTARGET"] = "專注目標的目標"
L["ICONMENU_FRIEND"] = "友好"
L["ICONMENU_GHOUL"] = "非永久食尸鬼"
L["ICONMENU_GHOUL_DESC"] = "僅用於在你沒有加 %s 這個天賦時,檢查你的食屍鬼持續時間."
L["ICONMENU_HIDEUNEQUIPPED"] = "當武器欄為空時隱藏"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "勾選此項在檢查的武器欄沒有裝備武器時強制隱藏圖示"
L["ICONMENU_HOSTILE"] = "敵對"
L["ICONMENU_ICD"] = "內置冷卻/法術持續時間"
L["ICONMENU_ICDAURA_DESC"] = [=[選擇此項,如果內置冷卻是在你獲得一個增益/減益後開始(包括觸發)或是在充能效果使你恢復法力值/怒氣/等之後開始.

你需要在 %q 編輯框中輸入你獲得的使你觸發內置冷卻的增益/減益的名稱/ID或者是充能效果的名稱/ID

(請檢查你的戰鬥記錄或者利用插件來確認法術名稱/ID)]=]
L["ICONMENU_ICDBDE"] = "增益/減益/充能/召喚"
L["ICONMENU_ICD_DESC"] = [=[檢查一個觸發效果或與其類似效果的冷卻.

|cFFFF5959重要提示|r:關於如何檢查每種類型的內置冷卻請參閱在 %q 下方選項的提示資訊.]=]
L["ICONMENU_ICDTYPE"] = "何時觸發"
L["ICONMENU_ICONUNIT"] = "<圖示單位>"
L["ICONMENU_ICONUNIT_DESC"] = "插入單位變數\"%u\",它將檢查圖示當前正在檢查的所有單位."
L["ICONMENU_IGNORENOMANA"] = "忽略能量不足"
L["ICONMENU_IGNORENOMANA_DESC"] = [=[勾選此項當一個技能僅僅是因為能量不足而不可用時視該技能為可用.  

對於像是%s 或者 %s這類技能很實用.]=]
L["ICONMENU_IGNORERUNES"] = "忽略符文"
L["ICONMENU_IGNORERUNES_DESC"] = "勾選此項,如果阻礙技能冷卻的只是一個符文冷卻(或公共CD)時視為技能冷卻可用."
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "\"忽略符文\"必須在\"冷卻檢查\"已勾選後才可使用."
L["ICONMENU_INVERTBARS"] = "反轉計量條"
L["ICONMENU_INVERTBARS_DESC"] = "勾選此項在能量值足以施放法術 或者 持續時間到0時顯示為完全填滿的計量條."
L["ICONMENU_ITEMCOOLDOWN"] = "物品冷卻"
L["ICONMENU_ITEMCOOLDOWN_DESC"] = "檢查物品冷卻."
L["ICONMENU_MANACHECK"] = "能量檢查"
L["ICONMENU_MANACHECK_DESC"] = [=[勾選此項啟用當你法力/怒氣/符能等等不足時改變圖示顏色(或視為不可用).

注:除非特別說明,本插件中的能量一般是指法術施放所需的法力/怒氣/符能/集中值等等,並非盜賊/野德的能量值.]=]
L["ICONMENU_META"] = "整合圖示"
L["ICONMENU_META_DESC"] = [=[組合多個圖示到一個圖示.

在整合圖示中被檢查的那些圖示即使設定為%q,在可以顯示時同樣會顯示.]=]
L["ICONMENU_MOUSEOVER"] = "滑鼠游標目標"
L["ICONMENU_MOUSEOVERTARGET"] = "滑鼠游標目標的目標"
L["ICONMENU_MOVEHERE"] = "移動到此"
L["ICONMENU_MULTISTATECD"] = "多重狀態技能"
L["ICONMENU_MULTISTATECD_DESC"] = [=[檢查一個有多重狀態的技能.

此圖示類型應當在你要檢查像是 %s 或 %s 這些多重狀態/材質的冷卻時間時使用.]=]
L["ICONMENU_MUSHROOMS"] = "%s"
L["ICONMENU_MUSHROOMS_DESC"] = "檢查%s."
L["ICONMENU_OFFS"] = "位移"
L["ICONMENU_ONLYBAGS"] = "只在背包中存在時"
L["ICONMENU_ONLYBAGS_DESC"] = "勾選此項當物品在背包中(或者已裝備)時顯示圖示.如果啟用'已裝備的物品',此選項會被強制啟用."
L["ICONMENU_ONLYEQPPD"] = "只在已裝備時"
L["ICONMENU_ONLYEQPPD_DESC"] = "勾選這個來使圖示只在物品已裝備時顯示."
L["ICONMENU_ONLYIFCOUNTING"] = "僅在計時器作用時顯示"
L["ICONMENU_ONLYIFCOUNTING_DESC"] = "勾選此項使圖示僅在當前有一個作用中的計時器正在運行並且它的持續時間大於0時顯示."
L["ICONMENU_ONLYINTERRUPTIBLE"] = "僅可中斷"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "選中此框僅顯示可中斷的施法"
L["ICONMENU_ONLYMINE"] = "僅檢查自己施放的"
L["ICONMENU_ONLYMINE_DESC"] = "勾選此項讓該圖示只顯示你施放的增益或減益"
L["ICONMENU_ONLYSEEN"] = "僅顯示施放過的法術"
L["ICONMENU_ONLYSEEN_DESC"] = "選擇此項可以讓圖示只顯示某單位至少施放過一次的法術冷卻.如果你在同一個圖示檢查不同職業的法術那麼應該勾上它."
L["ICONMENU_OVERLAYBARHEADER"] = "覆蓋計量條"
L["ICONMENU_PETTARGET"] = "寵物的目標"
L["ICONMENU_PRESENT"] = "存在時"
L["ICONMENU_RANGECHECK"] = "距離檢查"
L["ICONMENU_RANGECHECK_DESC"] = "勾選此項啟用當你超出範圍時改變圖示顏色(或視為不可用)."
L["ICONMENU_REACT"] = "單位反映"
L["ICONMENU_REACTIVE"] = "觸發性技能"
L["ICONMENU_REACTIVE_DESC"] = [=[檢查觸發性技能的可用情況.

觸發性的技能指類似%s, %s 和 %s 這些只能在某種特定條件下使用的技能.]=]
L["ICONMENU_RUNES"] = "符文冷卻"
L["ICONMENU_RUNES_DESC"] = "檢查符文冷卻."
L["ICONMENU_SHOWCBAR_DESC"] = "將會在跟圖示重疊的下半部份顯示剩餘的冷卻/持續時間的計量條(或是在'反轉計量條'啟用的情況下顯示已用的時間)"
L["ICONMENU_SHOWCBARN"] = "計時條"
L["ICONMENU_SHOWPBAR_DESC"] = [=[將會在跟圖示重疊的上半部份方顯示你施放此法術還需多少能量的能量條(或是在'反轉計量條'啟用的情況下顯示當前的能量).

註:這個能量可以是盜賊的能量,戰士的怒氣,獵人的集中值,其他職業的法力值等等.]=]
L["ICONMENU_SHOWPBARN"] = "能量條"
L["ICONMENU_SHOWSTACKS"] = "顯示堆疊數量"
L["ICONMENU_SHOWSTACKS_DESC"] = "勾選此項顯示物品的堆疊數量並啟用堆疊數量條件."
L["ICONMENU_SHOWTIMER"] = "顯示計時器"
L["ICONMENU_SHOWTIMER_DESC"] = "勾選此項讓該圖示的冷卻時鐘動畫在可用時顯示.(注:此選項僅影響圖示的時鐘動畫,就是技能冷卻時的那個轉圈效果,不包括數字在內哦.)"
L["ICONMENU_SHOWTIMERTEXT"] = "顯示計時器數字"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [=[勾選此項在圖示上顯示剩餘冷卻時間或持續時間的數字.

需要已安裝OmniCC或者其他冷卻計時插件才可使用.(注:某些冷卻計時插件可能不支持此選項)]=]
L["ICONMENU_SHOWTTTEXT"] = "顯示變數文字"
L["ICONMENU_SHOWTTTEXT_DESC"] = [=[勾選此項在堆疊數量文字的位置上顯示從法術效果的提示資訊中找到的第一個變數(數字).比如用此監視傷害護盾的剩餘吸收量等等.

數字是由暴雪API所提供,跟你在法術效果的提示資訊中看到的數字可能會不同(像是伺服器已經在線修正,客戶端依然顯示錯誤的數字這種情況),在大多數情況下都能顯示正確的數字.]=]
L["ICONMENU_SHOWWHEN"] = "何時顯示圖示"
L["ICONMENU_SORTASC"] = "持續時間升序"
L["ICONMENU_SORTASC_DESC"] = "勾選此項優先顯示持續時間最低的法術."
L["ICONMENU_SORTDESC"] = "持續時間降序"
L["ICONMENU_SORTDESC_DESC"] = "勾選此項優先顯示持續時間最高的法術."
L["ICONMENU_SPELL"] = "法術或技能"
L["ICONMENU_SPELLCAST_COMPLETE"] = "施法結束/瞬發"
L["ICONMENU_SPELLCAST_COMPLETE_DESC"] = [=[選擇此項如果內置冷卻需要在你施法結束後才開始,或是在你施放一個瞬發法術後開始.

你需要在 %q 編輯框中輸入那個觸發內置冷卻的法術名稱或ID.]=]
L["ICONMENU_SPELLCAST_START"] = "施法開始"
L["ICONMENU_SPELLCAST_START_DESC"] = [=[選擇此項如果內置冷卻是在開始施法後就觸發.

你需要在 %q 編輯框中輸入那個觸發內置冷卻的法術名稱或ID.]=]
L["ICONMENU_SPELLCOOLDOWN"] = "法術冷卻"
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "檢查在你法術書中那些法術的冷卻."
L["ICONMENU_SPLIT"] = "拆分成新的群組"
L["ICONMENU_SPLIT_DESC"] = "創建一個新的群組並將這個圖示移動到上面. 原群組中的許多設定會保留到新的群組."
L["ICONMENU_STACKS_MAX_DESC"] = "允許圖示顯示的最大堆疊數量,高於此數值圖示將被隱藏."
L["ICONMENU_STACKS_MIN_DESC"] = "顯示圖示所需的最低堆疊數量,低於此數值圖示將被隱藏."
L["ICONMENU_STEALABLE"] = "僅可法術竊取"
L["ICONMENU_STEALABLE_DESC"] = "勾選此項僅顯示能被\"法術竊取\"的增益,非常適合跟驅散類型中的魔法搭配使用."
L["ICONMENU_SUCCEED"] = "成功通過時"
L["ICONMENU_SWAPWITH"] = "交換位置"
L["ICONMENU_TARGETTARGET"] = "目標的目標"
L["ICONMENU_TOTEM"] = "圖騰"
L["ICONMENU_TOTEM_DESC"] = "檢查你的圖騰."
L["ICONMENU_TYPE"] = "圖示類型"
L["ICONMENU_UNITCOOLDOWN"] = "單位冷卻"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[檢查其他單位的冷卻.

檢查 %s 可以使用 %q 作為名稱.

注:玩家也可以作為被檢查的單位.]=]
L["ICONMENU_UNIT_DESC"] = [=[在此框輸入需要監視的單位.此單位能從下拉列表插入到右邊,或者你是一位高端玩家可以自行輸入需要監視的單位.
多個單位請用分號分隔開(;)
可使用標準單位(像是player,target,mouseover等等可用於巨集的單位),或者是友好玩家的名字(像是%s,Cybeloras,小兔是豬,阿光是豬等.)

需要更多關於單位的資訊,請訪問http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNITS"] = "單位"
L["ICONMENU_UNITSTOWATCH"] = "監視的單位"
L["ICONMENU_UNUSABLE"] = "不可用"
L["ICONMENU_USABLE"] = "可用"
L["ICONMENU_USEACTIVATIONOVERLAY"] = "檢查技能激活邊框"
L["ICONMENU_USEACTIVATIONOVERLAY_DESC"] = "檢查系統默認提示技能可用時的黃色發光邊框."
L["ICONMENU_VEHICLE"] = "載具"
L["ICONMENU_WPNENCHANT"] = "暫時性武器附魔"
L["ICONMENU_WPNENCHANT_DESC"] = "檢查暫時性的武器附魔"
L["ICONMENU_WPNENCHANTTYPE"] = "監視的武器欄"
L["ICONTOCHECK"] = "要檢查的圖示"
L["ICON_TOOLTIP1"] = "TellMeWhen"
L["ICON_TOOLTIP2NEW"] = [=[|cff7fffff點擊滑鼠右鍵|r進入圖示設定.
|cff7fffff點擊滑鼠右鍵並拖曳|r 複製/移動 到另一個圖示.
|cff7fffff拖曳|r法術或物品到圖示來快速設定.]=]
L["ImmuneToMagicCC"] = "免疫法術控制"
L["ImmuneToStun"] = "免疫擊暈"
L["IMPORTERROR_FAILEDPARSE"] = "處理字串時發生錯誤.請確保你複製的字串是完整的."
L["IMPORT_EXPORT"] = "匯入/匯出/還原"
L["IMPORT_EXPORT_BUTTON_DESC"] = "點擊此下拉式選單來匯出或匯入圖示/群組/設定檔."
L["IMPORT_EXPORT_DESC"] = [=[點擊這個編輯框右側的下拉式選單的箭頭來匯出圖示,群組或設定檔.

匯出/匯入字串或發送給其他玩家需要使用這個編輯框. 具體的使用方法請看下拉式選單上的提示資訊.]=]
L["IMPORT_EXPORT_DESC_INLINE"] = "匯出設定檔/群組/圖示到字串/其他玩家/其他設定檔/個人設定備份. 或從字串/其他玩家/其他設定檔/個人設定備份匯入到設定檔/群組/圖示."
L["IMPORT_FROMBACKUP"] = "來自備份"
L["IMPORT_FROMBACKUP_DESC"] = "用此選單可以還原設定到: %s "
L["IMPORT_FROMBACKUP_WARNING"] = "備份設定: %s"
L["IMPORT_FROMCOMM"] = "來自玩家"
L["IMPORT_FROMCOMM_DESC"] = "如果另一個TellMeWhen使用者給你發送了配置數據,可以從這個子選單匯入那些數據."
L["IMPORT_FROMLOCAL"] = "來自設定檔"
L["IMPORT_FROMSTRING"] = "來自字串"
L["IMPORT_FROMSTRING_DESC"] = [=[字串允許你在遊戲以外的地方轉存TellMeWhen配置數據.(包括用來給其他人分享自己的設定,或者匯入其他人分享的設定,也可用來備份你自己的設定.)

從字串匯入的方法: 當複製TMW字串到你的剪貼簿後,在'匯出/匯入'編輯框中按下CTRL+V貼上字串,然後返回瀏覽這個子選單.]=]
L["IMPORT_FROMSTRING_ERR_NOICONS"] = "請使用'圖示編輯器'匯入圖示"
L["IMPORT_HEADING"] = "匯入"
L["IMPORT_PROFILE"] = "複製設定檔"
L["IMPORT_PROFILE_NEW"] = "創建新的設定檔"
L["IMPORT_PROFILE_OVERWRITE"] = "覆蓋 %s"
L["Incapacitated"] = "癱瘓"
L["IncreasedAP"] = "攻擊強度提高"
L["IncreasedCrit"] = "致命等級提高"
L["IncreasedDamage"] = "造成的傷害提高"
L["IncreasedPhysHaste"] = "攻擊加速提高"
L["IncreasedSpellHaste"] = "施法加速提高"
L["IncreasedSPsix"] = "法術能量提高 (6%)"
L["IncreasedSPten"] = "法術能量提高 (10%)"
L["IncreasedStats"] = "屬性提高"
L["INRANGE"] = "在範圍內"
L["ITEMCOOLDOWN"] = "物品冷卻"
L["ITEMEQUIPPED"] = "已裝備的物品"
L["ITEMINBAGS"] = "物品計數(包含使用次數)"
L["ITEMTOCHECK"] = "要檢查的物品"
L["ITEMTOCOMP1"] = "進行比較的第一個物品"
L["ITEMTOCOMP2"] = "進行比較的第二個物品"
L["LDB_TOOLTIP1"] = "|cff7fffff左鍵點擊|r 鎖定圖示組"
L["LDB_TOOLTIP2"] = "|cff7fffff右鍵點擊|r 顯示TWM選項"
L["LEFT"] = "左"
L["LOADERROR"] = "TellMeWhen設定插件無法載入:"
L["LOADINGOPT"] = "正在載入TellMeWhen設定插件."
L["LOCKED"] = "已鎖定"
L["LUACONDITION"] = "Lua(進階)"
L["LUACONDITION_DESC"] = [=[此條件類型允許你使用Lua語言來評估一個條件的狀態.

輸入不能為'if..then'敘述,也不能為function closure.它可以是一個普通的敘述評估,例如:'a and b or c'.如果需要複雜功能,可使用函數調用,例如:'CheckStuff()',這是一個外部函數.

如果需要更多的幫助(但不是關於如何去寫Lua代碼),到CurseForge提交一份回報單.關於如何編寫Lua语言,請自行去互聯網搜尋資料.

PS:Lua語言部份就不翻譯了,翻譯了反而覺得怪怪的.]=]
L["MACROCONDITION"] = "巨集條件式"
L["MACROCONDITION_DESC"] = [=[此條件將會評估巨集的條件式,在巨集條件式成立時則此條件通過.
所有的巨集條件式都能在前面加上"no"進行逆向檢查.
例子:
"[nomodifier:alt]" - 沒有按住ALT鍵
"[@target, help][mod:ctrl]" - 目標是友好的或者按住CTRL鍵
"[@focus, harm, nomod:shift]" - 專注目標是敵對的同時沒有按住SHIFT鍵

需要更多的幫助,請訪問http://www.wowpedia.org/Making_a_macro]=]
L["MACROCONDITION_EB_DESC"] = "使用單一條件時方括弧是可選的,使用多個條件式時方括弧是必須的.(說明:方括弧->'[ ]')"
L["MACROTOEVAL"] = "輸入需要評估的巨集條件式(允許多個)"
L["Magic"] = "魔法"
L["MAIN"] = "主頁面"
L["!!Main Addon Description"] = "為冷卻、增益/減益及其他各個方面提供視覺、聽覺以及文字上的通知。"
L["MAINASSIST"] = "主助攻"
L["MAINTANK"] = "主坦克"
L["MAKENEWGROUP"] = "創建新群組"
L["ManaRegen"] = "法力回復提高"
L["MELEECRIT"] = "近戰致命"
L["MELEEHASTE"] = "近戰加速"
L["MESSAGERECIEVE"] = "%s給你發送了一些TellMeWhen的數據! 你可以利用圖示編輯器中的 %q 下拉式選單匯入這些數據到TellMeWhen."
L["MESSAGERECIEVE_SHORT"] = "%s給你發送了一些TellMeWhen數據!"
L["METAPANEL_DOWN"] = "向下移動"
L["METAPANEL_INSERT"] = "插入一個圖示"
L["METAPANEL_REMOVE"] = "移除此圖示"
L["METAPANEL_UP"] = "向上移動"
L["MiscHelpfulBuffs"] = "雜項-其他增益"
L["MOON"] = "月蝕"
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "無滑鼠游標目標"
L["MP5"] = "%d 5秒回藍"
L["MUSHROOM"] = "蘑菇%d"
L["MUSHROOMS"] = "檢查蘑菇"
L["NEWVERSION"] = "TellMeWhen可升級新版本(%s)"
L["NONE"] = "不包含任何一個"
L["normal"] = "普通"
L["NOTINRANGE"] = "不在範圍內"
L["NUMAURAS"] = "數量"
L["NUMAURAS_DESC"] = [=[此條件僅檢查一個作用中的法術效果的數量 - 不要與法術效果的堆疊數量混淆.
像是你的兩個相同的武器附魔特效同時觸發並且在作用中.
請有節制的使用它,此過程需要消耗不少CPU運算來計算數量.]=]
L["ONGROUPDELETE_CHECKINGINVALID"] = "警告!下列群組和圖示正在檢查那個剛被你刪除的群組中的某些圖示:"
L["ONLYCHECKMINE"] = "僅檢查自己施放的"
L["ONLYCHECKMINE_DESC"] = "勾選此項讓此條件只檢查自己的增益/減益."
L["OUTLINE_MONOCHORME"] = "單色"
L["OUTLINE_NO"] = "無描邊"
L["OUTLINE_THICK"] = "粗描邊"
L["OUTLINE_THIN"] = "細描邊"
L["OVERWRITEGROUP"] = "覆蓋群組:%s"
L["PARENTHESIS_TYPE_("] = "左括弧'('"
L["PARENTHESIS_TYPE_)"] = "右括弧')'"
L["PARENTHESIS_WARNING1"] = [=[左右括弧的数量不相等!

缺少%d個%s.]=]
L["PARENTHESIS_WARNING2"] = [=[一些右括弧缺少左括弧.

缺少%d個左括弧'('.]=]
L["PET_TYPE_CUNNING"] = "靈巧"
L["PET_TYPE_FEROCITY"] = "兇暴"
L["PET_TYPE_TENACITY"] = "堅毅"
L["PhysicalDmgTaken"] = "受到的物理傷害提高"
L["PLAYER_DESC"] = "(你)"
L["Poison"] = "毒"
L["PRESENCE"] = "領域"
L["PushbackResistance"] = "施法打退抵抗提高"
L["PvPSpells"] = "PVP控制技能以及其它"
L["RANGEDCRIT"] = "物理遠程致命"
L["RANGEDHASTE"] = "物理遠程加速"
L["rare"] = "稀有"
L["rareelite"] = "稀有精英"
L["REACTIVECNDT_DESC"] = "此條件僅檢查技能的觸發/可用情況.並非它的冷卻."
L["REDO_ICON"] = "重作"
L["REDO_ICON_DESC"] = "重作最近一次圖示設定的復原動作."
L["ReducedArmor"] = "護甲值降低"
L["ReducedAttackSpeed"] = "攻擊速度降低"
L["ReducedCastingSpeed"] = "施法速度降低"
L["ReducedHealing"] = "治療效果降低"
L["ReducedPhysicalDone"] = "造成的物理傷害降低"
L["RESET_CONFIRM"] = "確認重設"
L["RESET_EXPIRE"] = "重設已超時,你沒有在5秒內再次按下'重設'按鈕."
L["RESET_ICON"] = "重設"
L["RESET_NOTIFY"] = "請於5秒內再次按下 '重設' 按鈕 ."
L["Resistances"] = "法術抗性提高"
L["RESIZE"] = "改變大小"
L["RESIZE_TOOLTIP"] = "點擊並拖曳改變大小"
L["RIGHT"] = "右"
L["Rooted"] = "纏繞"
L["RUNES"] = "要檢查的符文"
L["RUNSPEED"] = "單位奔跑速度"
L["SENDSUCCESSFUL"] = "發送完成"
L["SHAPESHIFT"] = "變身"
L["Shatterable"] = "冰凍"
L["Silenced"] = "沉默"
L["Slowed"] = "緩速"
L["SORTBY"] = "排序方式"
L["SORTBYNONE"] = "正常排序"
L["SORTBYNONE_DESC"] = [=[如果選中,法術將按照"%s"編輯框中的輸入順序來檢查並排序.
如果是一個增益/減益圖示,只要出現在單位框體上的法術效果數字沒有超出效率閥值設定,就會被檢查並排序.

(P.S.如果看不懂請無視這段說明,只要知道它是按照你輸入的順序來排序就好.)]=]
L["SOUND_CUSTOM"] = "自訂音效檔案"
L["SOUND_CUSTOM_DESC"] = [=[輸入需要用來播放的自訂音效檔案的路徑.
下面是一些例子,其中"File"是你的音效檔案名,"ext"是副檔名(只能用ogg或者mp3格式)

-"CustomSounds\File.ext": 一個檔案放在WOW根目錄一個命名為"CustomSound"的新建资料夾中(此資料夾同WOW.exe,Interface和WTF在同一個位置)
-"Interface\AddOns\file.ext": 插件资料夾中的某一檔案
-"file.ext":  WOW主目錄的某個檔案]=]
L["SOUNDERROR1"] = "檔案必須有一個副檔名!"
L["SOUNDERROR2"] = "魔獸世界4.0+不支援自訂WAV檔案"
L["SOUNDERROR3"] = "只支援OGG和MP3檔案!"
L["SOUND_EVENT_DISABLEDFORTYPE"] = "不可用"
L["SOUND_EVENT_DISABLEDFORTYPE_DESC"] = "此事件不可用於圖示類型 %s"
L["SOUND_EVENT_GLOBALDESC"] = "在此列表中的事件是按照從上到下的順序來檢查.如果一個事件觸發並且播放了音效,在它之後的事件不會再播放任何音效."
L["SOUND_EVENT_ONALPHADEC"] = "透明度百分比減少"
L["SOUND_EVENT_ONALPHADEC_DESC"] = [=[當圖示的不透明度降低時觸發此事件.

注意:不透明度在降低後如果為0%不會觸發此事件(如果有需要請使用"在隱藏時").]=]
L["SOUND_EVENT_ONALPHAINC"] = "透明度百分比增加"
L["SOUND_EVENT_ONALPHAINC_DESC"] = [=[當圖示的不透明度提高時觸發此事件.

注意:不透明度在提高前如果為0%不會觸發此事件(如果有需要請使用"在顯示時").]=]
L["SOUND_EVENT_ONDURATION"] = "持續時間改變"
L["SOUND_EVENT_ONDURATION_DESC"] = [=[此事件在圖示計時器的持續時間改變時觸發.

因為在計時器運行時每次圖示更新都會觸發該事件,你必須設定一個條件,使事件僅在條件的狀態改變時觸發.]=]
L["SOUND_EVENT_ONFINISH"] = "結束"
L["SOUND_EVENT_ONFINISH_DESC"] = "當冷卻完成,增益/減益消失,等類似的情況下觸發此事件. "
L["SOUND_EVENT_ONHIDE"] = "隱藏"
L["SOUND_EVENT_ONHIDE_DESC"] = "當圖示隱藏時觸發此事件(即使 %q 已勾選)."
L["SOUND_EVENT_ONSHOW"] = "顯示"
L["SOUND_EVENT_ONSHOW_DESC"] = "當圖示顯示時觸發此事件(即使 %q 已勾選)."
L["SOUND_EVENT_ONSPELL"] = "法術改變"
L["SOUND_EVENT_ONSPELL_DESC"] = "當圖示顯示資訊中的法術/物品/等改變時觸發此事件."
L["SOUND_EVENT_ONSTACK"] = "堆疊數量改變"
L["SOUND_EVENT_ONSTACK_DESC"] = [=[此事件在圖示所檢查的法術/物品等的堆疊數量發生改變時觸發.

包括逐漸降低的%s圖示.]=]
L["SOUND_EVENT_ONSTART"] = "開始"
L["SOUND_EVENT_ONSTART_DESC"] = "當冷卻開始,增益/減益開始作用,等類似的情況下觸發此事件."
L["SOUND_EVENT_ONUNIT"] = "單位改變"
L["SOUND_EVENT_ONUNIT_DESC"] = "當圖示顯示資訊中的單位改變時觸發此事件."
L["SOUND_EVENTS"] = "圖示事件"
L["SOUND_SOUNDTOPLAY"] = "要播放的音效"
L["SOUND_TAB"] = "音效"
L["SOUND_USEMASTER"] = "總是播放音效"
L["SOUND_USEMASTER_DESC"] = "勾選此項允許在遊戲音效靜音時同樣播放音效(最上面的開啟音效必須打開),取消此項只在遊戲音效開啟時播放音效."
L["SPEED"] = "單位速度"
L["SPEED_DESC"] = [=[這是指單位當前的移動速度,如果單位不移動則為0.
如果您要檢查單位的最高奔跑速度,可以使用'單位奔跑速度'條件來代替.]=]
L["SPELLCOOLDOWN"] = "法術冷卻"
L["SPELLCRIT"] = "法術致命"
L["SpellCritTaken"] = "受到法術致命一擊幾率提高"
L["SpellDamageTaken"] = "受到的法術傷害提高"
L["SPELLHASTE"] = "施法加速"
L["SPELLREACTIVITY"] = "法術反應(激活/觸發/可用)"
L["SPELLTOCHECK"] = "要檢查的法術"
L["SPELLTOCOMP1"] = "進行比較的第一個法術"
L["SPELLTOCOMP2"] = "進行比較的第二個法術"
L["STACKS"] = "堆疊數量"
L["STACKSPANEL_TITLE"] = "堆疊數量"
L["STANCE"] = "姿態"
L["STRATA_BACKGROUND"] = "背景(最低)"
L["STRATA_DIALOG"] = "對話框"
L["STRATA_FULLSCREEN"] = "全螢幕"
L["STRATA_FULLSCREEN_DIALOG"] = "全螢幕對話框"
L["STRATA_HIGH"] = "高"
L["STRATA_LOW"] = "低"
L["STRATA_MEDIUM"] = "中"
L["STRATA_TOOLTIP"] = "提示資訊(最高)"
L["Stunned"] = "擊暈"
L["SUG_BUFFEQUIVS"] = "同類型增益"
L["SUG_CLASSSPELLS"] = "已知的玩家/寵物法術"
L["SUG_DEBUFFEQUIVS"] = "同類型減益"
L["SUG_DISPELTYPES"] = "驅散類型"
L["SUG_FINISHHIM"] = "馬上結束快取"
L["SUG_FINISHHIM_DESC"] = "點擊快速完成該快取/篩選過程.友情提示:您的電腦可能會因此停格幾秒鐘."
L["SUGGESTIONS"] = "提示與建議:"
L["SUG_INSERT_ANY"] = "|cff7fffff點擊滑鼠|r"
L["SUG_INSERTID"] = "%s插入編號(ID)"
L["SUG_INSERTITEMSLOT"] = "%s插入物品對應的裝備欄位編號"
L["SUG_INSERT_LEFT"] = "|cff7fffff點擊滑鼠左鍵|r"
L["SUG_INSERTNAME"] = "%s插入名稱"
L["SUG_INSERT_RIGHT"] = "|cff7fffff點擊滑鼠右鍵|r"
L["SUG_MATCH_WPNENCH_ENCH"] = "(.*)武器"
L["SUG_MISC"] = "雜項"
L["SUG_MSCDONBARS"] = "有效的多重狀態冷卻"
L["SUG_NPCAURAS"] = "已知NPC的增益/減益"
L["SUG_OTHEREQUIVS"] = "其它同類型"
L["SUG_PATTERNMATCH_FISHINGLURE"] = "魚餌%(%+%d+釣魚技能%)"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "磨利%(%+%d+傷害%)"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "增重%(%+%d+傷害%)"
L["SUG_PLAYERAURAS"] = "已知玩家/寵物的增益/減益"
L["SUG_PLAYERSPELLS"] = "你的法術"
L["SUG_TOOLTIPTITLE"] = [=[當你輸入時,TellMeWhen將會在快取中查找並提示你最有可能輸入的法術.

法術按照以下列表分類跟著色.
注意:在記錄到相應的數據之前或是在你沒有登入过其他職業的情況下不會把那些法術放入"已知"開頭的分類中.

點擊一個條目將其插入到編輯框.

]=]
L["SUN"] = "日蝕"
L["TANK"] = "坦克"
L["Tier11Interrupts"] = "T11副本可中斷的施法"
L["Tier12Interrupts"] = "T12副本可中斷法術"
L["TOOLTIPSCAN"] = "法術效果變數"
L["TOOLTIPSCAN_DESC"] = "此條件類型允許你檢查某一單位的某個法術效果提示資訊上的第一個變數(數字). 數字是由暴雪API所提供,跟你在法術效果的提示資訊中看到的數字可能會不同(像是伺服器已經在線修正,客戶端依然顯示錯誤的數字這種情況),同時也不保證一定能夠從法術效果取得一個數字,不過在大多數實際情況下都能檢查到正確的數字."
L["TOP"] = "上"
L["TOPLEFT"] = "左上"
L["TOPRIGHT"] = "右上"
L["TOTEMS"] = "檢查圖騰"
L["TRUE"] = "是"
L["UIPANEL_ADDGROUP"] = "+ 新增群組 +"
L["UIPANEL_ADDGROUP_DESC"] = "新群組將指定下一個可用的群組ID"
L["UIPANEL_ALLRESET"] = "全部重設"
L["UIPANEL_BARIGNOREGCD"] = "計量條忽略公共冷卻"
L["UIPANEL_BARIGNOREGCD_DESC"] = "如果選中,冷卻條在公共冷卻時不改變值."
L["UIPANEL_BARTEXTURE"] = "計量條材質"
L["UIPANEL_CLOCKIGNOREGCD"] = "計時器忽略公共CD"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "如果選中,計時器和冷卻時鐘不會從公共CD觸發."
L["UIPANEL_COLOR_ABSENT"] = "缺少時的顏色"
L["UIPANEL_COLOR_ABSENT_DESC"] = "當增益/減益/暫時性武器附魔/圖騰不存在並且圖示設定為一直顯示時圖示的色調。"
L["UIPANEL_COLOR_COMPLETE"] = "冷卻/持續時間結束"
L["UIPANEL_COLOR_COMPLETE_DESC"] = "冷卻/持續時間計量條結束時的顏色"
L["UIPANEL_COLOR_DESC"] = "下列選項的圖示顏色僅作用於圖示設定為一直顯示時"
L["UIPANEL_COLOR_OOM"] = "能量不足顏色"
L["UIPANEL_COLOR_OOM_DESC"] = "當您的法力/怒氣/能量/集中值/符能不足以施放法術時圖示的色調和透明度"
L["UIPANEL_COLOR_OOR"] = "超出距離顏色"
L["UIPANEL_COLOR_OOR_DESC"] = "當您的目標不在施放法術範圍內圖示的色調和透明度"
L["UIPANEL_COLOR_PRESENT"] = "存在時的顏色"
L["UIPANEL_COLOR_PRESENT_DESC"] = "當增益/減益/暫時性武器附魔/圖騰存在並且圖示設定為一直顯示時圖示的色調。"
L["UIPANEL_COLORS"] = "顏色"
L["UIPANEL_COLOR_STARTED"] = "冷卻/持續時間開始"
L["UIPANEL_COLOR_STARTED_DESC"] = "冷卻/持續時間計量條開始時的顏色"
L["UIPANEL_COLUMNS"] = "列"
L["UIPANEL_DELGROUP"] = "刪除此群組"
L["UIPANEL_DELGROUP_DESC"] = [=[在此群組之後的群組ID將會上升1.
同時對ID上升群組的圖示有檢查行為的所有圖示的設定也將自動更新.

按住|cff7fffffCtrl|r繞過確認..]=]
L["UIPANEL_DRAWEDGE"] = "高亮計時器指針"
L["UIPANEL_DRAWEDGE_DESC"] = "高亮冷卻計時器指針(時鐘動畫)來突出顯示效果"
L["UIPANEL_EFFTHRESHOLD"] = "增益效率閥值"
L["UIPANEL_EFFTHRESHOLD_DESC"] = [=[輸入增益/減益的最小時間以便在它們有很高的數值時切換到更有效的檢查模式. 注意:一旦效果的數值超出所選擇的數字的限定,數值較大的效果會優先顯示,而不是按照設定的優先級順序.
]=]
L["UIPANEL_ENABLEGROUP"] = "啟用此群組"
L["UIPANEL_FONT_Bind"] = "綁定/標籤文字"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "限制寬度"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [=[勾選此項在位置恰當的情況下文字寬度會強制跟圖示寬度進行匹配.
取消勾選將允許文字延升寬度大於圖示.]=]
L["UIPANEL_FONT_Count"] = "堆疊數量文字"
L["UIPANEL_FONT_DESC"] = "選擇圖示堆疊數量文字的字型"
L["UIPANEL_FONTFACE"] = "字型"
L["UIPANEL_FONT_OUTLINE"] = "文字描邊"
L["UIPANEL_FONT_OUTLINE_DESC"] = "設定圖示堆疊數量文字的描邊樣式."
L["UIPANEL_FONT_OVERRIDELBF"] = "使用Masque(ButtonFacade)覆蓋位置"
L["UIPANEL_FONT_OVERRIDELBF_DESC"] = [=[勾選此項在Masque(ButtonFacade)皮膚的設定已定義時覆蓋堆疊數量文字位置.如果你沒有使用Masque(ButtonFacade)請忽略此選項.

如果你選擇在啟用之後禁用此選項來還原文字的皮膚設定需要重載插件或更改皮膚.]=]
L["UIPANEL_FONT_SIZE"] = "字體大小"
L["UIPANEL_FONT_SIZE_DESC"] = "更改圖示堆疊數量文字的字體大小.如果已使用ButtonFacade(Masque)並且所設定的皮膚的字體大小已定義將忽略此設定值."
L["UIPANEL_FONT_XOFFS"] = "X位移"
L["UIPANEL_FONT_YOFFS"] = "Y位移"
L["UIPANEL_GROUPNAME"] = "重命名群組"
L["UIPANEL_GROUPRESET"] = "重設位置"
L["UIPANEL_GROUPS"] = "群組"
L["UIPANEL_ICONS"] = "圖示"
L["UIPANEL_ICONSPACING"] = "圖示間隔"
L["UIPANEL_ICONSPACING_DESC"] = "同組圖示彼此之間的間隔距離"
L["UIPANEL_LEVEL"] = "框體優先級"
L["UIPANEL_LOCK"] = "鎖定位置"
L["UIPANEL_LOCK_DESC"] = "鎖定此群組,防止移動或改變比例大小"
L["UIPANEL_LOCKUNLOCK"] = "鎖定/解鎖插件"
L["UIPANEL_MAINOPT"] = "主選項"
L["UIPANEL_ONLYINCOMBAT"] = "只在戰鬥中顯示"
L["UIPANEL_POINT"] = "依附錨點"
L["UIPANEL_POSITION"] = "位置"
L["UIPANEL_PRIMARYSPEC"] = "主要天賦"
L["UIPANEL_PTSINTAL"] = "天賦使用點數(非天賦樹)"
L["UIPANEL_RELATIVEPOINT"] = "依附位置"
L["UIPANEL_RELATIVETO"] = "依附框體"
L["UIPANEL_RELATIVETO_DESC"] = [=[輸入'/framestack'來觀察當前滑鼠游標所在框體的提示資訊,以便尋找需要輸入編輯框的框體名稱.

需要更多幫助,請訪問http://www.wowpedia.org/API_Region_SetPoint]=]
L["UIPANEL_ROWS"] = "行"
L["UIPANEL_SCALE"] = "比例"
L["UIPANEL_SECONDARYSPEC"] = "第二天賦"
L["UIPANEL_SPEC"] = "雙天賦"
L["UIPANEL_STRATA"] = "框體層級"
L["UIPANEL_SUBTEXT2"] = [=[當圖示鎖定後TMW開始工作.
不鎖定時,你可以移動/更改圖示組的大小,或者右鍵點擊圖示得到更多的設定選項.
你同樣可以輸入/tellmewhen或/tmw來鎖定/解除鎖定.]=]
L["UIPANEL_TOOLTIP_ALLRESET"] = "重設所有圖示的數據和位置及其它設定"
L["UIPANEL_TOOLTIP_COLUMNS"] = "設定此群組的列數"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "顯示並啟用此群組"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "重設此群組位置跟比例"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "勾選此項讓該群組只在戰鬥中顯示"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "勾選後此群組圖示在主要天賦時可見"
L["UIPANEL_TOOLTIP_ROWS"] = "設定此群組的行數"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "勾選後此群組圖示在第二天賦時可見"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = "設定圖示顯示/隱藏,透明度,條件等的檢查頻率(秒).0為最快.低階電腦設定數值過低會使幀數明顯降低."
L["UIPANEL_TREE"] = "天賦樹"
L["UIPANEL_TREE_DESC"] = "勾選來允許該組在某個天賦樹激活時顯示,或者不勾選讓它在天賦樹沒激活時隱藏."
L["UIPANEL_UPDATEINTERVAL"] = "更新頻率"
L["UIPANEL_WARNINVALIDS"] = "提示無效圖示"
L["UNDO_ICON"] = "復原"
L["UNDO_ICON_DESC"] = "復原最近一次圖示設定的更改動作."
L["UNDOREDO_ICON_NOBIND"] = "你可以在暴雪的按鍵設定介面中為復原或重作設定一個快捷鍵."
L["UNITTWO"] = "第二單位"
L["UNNAMED"] = "((未命名))"
L["WARN_DRMISMATCH"] = [=[警告!你正在檢查遞減的法術來自兩個不同的已知分類.

在同一個遞減圖示中,用於檢查的所有法術應當使用同一遞減分類才能使圖示正常運作.

檢測到下列你所使用的法術及其分類:]=]
L["WATER"] = "水之圖騰"
L["worldboss"] = "首領"


