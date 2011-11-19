--[[-------------------------------------------------------
-- TinyTipOptions Localization : Chinese (Traditional)
-----------------------------------------------------------
-- Any wrong translations, change them here.
-- This file must be saved as UTF-8 compatible.
--
-- To get your client's locale, type in:
--
-- /script DEFAULT_CHAT_FRAME:AddMessage( GetLocale() )
--
-- Do not repost without permission from the author. If you
-- want to add a translation, contact the author.
--
-- Contributors:  舞葉@語風
--]]

if GetLocale() ~= "zhTW" then return end

TinyTipOptionsLocale = setmetatable({
    On = "開啟",
    Off = "關閉",
    GameDefault = "遊戲預設",
    TinyTipDefault = "TinyTip預設",

    -- TinyTipPositioning
    Opt_Main_Anchor= "錨點",
    Opt_MAnchor= "人物訊息錨點",
    Opt_FAnchor= "視窗訊息錨點",
    Opt_MOffX= "人物訊息列偏移量[X]",
    Opt_MOffY= "人物訊息列偏移量[Y]",
    Opt_FOffX= "視窗訊息列偏移量[X]",
    Opt_FOffY= "視窗訊息列偏移量[Y]",

    CURSOR = "游標",

    Map_Anchor = {
        ["LEFT"] = "左中",
        ["RIGHT"] = "右中",
        ["BOTTOMRIGHT"] = "右下",
        ["BOTTOMLEFT"] = "左下",
        ["BOTTOM"] = "正下方",
        ["TOP"] = "正上方",
        ["TOPLEFT"] = "左上",
        ["TOPRIGHT"] = "右上",
        ["CENTER"] = "正中央"
    },

    Desc_Main_Anchor = "設置訊息列位置。",
    Desc_MAnchor = "設定游標經過人物時顯示的訊息條錨點位置。",
    Desc_FAnchor = "設定游標經過任何物件時顯示的訊息條錨點位置。",
    Desc_MOffX = "設定人物訊息列相對於錨點的水平偏移量。",
    Desc_MOffY = "設定人物訊息列相對於錨點的垂直偏移量。",
    Desc_FOffX = "設定視窗訊息列相對於錨點的水平偏移量。",
    Desc_FOffY = "設定視窗訊息列相對於錨點的垂直偏移量。",

    -- TinyTipBasic
    Opt_Main_Text = "內文",
    Opt_HideRace = "隱藏職業和生物類型訊息",
    Opt_KeyElite = "啟用分類標示",
    Opt_PvPRankText = "官階訊息",
    Opt_LevelGuess = "預測等級",
    Opt_ReactionText = "顯示敵對狀態訊息",
    Opt_KeyServer = "用(*)取代伺服器名稱",

    Desc_Main_Text = "設定人物訊息列中顯示的內文訊息。",
    Desc_HideRace = "切換是否隱藏玩家職業和生物類型訊息。",
    Desc_KeyElite = "以++標示精英生物，以+標示稀有生物，以+++標示稀有精英生物，以(!)標示世界首領。",
    Desc_PvPRankText = "設定官階訊息顯示方式。",
    Desc_ReactionText = "切換是否顯示敵對狀態訊息。（友好，敵對等等。）",
    Desc_LevelGuess = "切換是以(你的等級 +10)還是以??顯示等級高出你10級以上的生物。",
    Desc_KeyServer = "如果玩家是來自另一個伺服器，則在名字後面用(*)取代伺服器名稱。",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance= "外觀",
    Opt_Scale= "縮放",
    Opt_Fade= "淡出效果",
    Opt_BGColor= "背景顏色",
    Opt_Border= "邊框顏色",
    Opt_ColourFriends= "以特別的顏色顯示好友與公會成員",
    Opt_HideInFrames= "隱藏人物頭像訊息列",

    Map_PvPRankText = {
        [1] =  "在名字後面顯示官階名",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "以玩家方式顯示NPC",
        [3] = "總是顯示黑色"
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "隱藏邊框",
    },

    Map_ColourFriends = {
        [1] = "只對名字上色",
        [2] = "不上色",
    },

    Desc_Main_Appearance = "設定訊息列外觀與行為。",
    Desc_Scale =  "設定訊息列的縮放比例。（包括附帶的圖示）",
    Desc_BGColor = "設定人物訊息列背景的顏色設定。",
    Desc_Border = "設定人物訊息列邊框的顏色設定。",
    Desc_ColourFriends = "設定是否使用特别的顏色顯示好友和同公會成員的名字或訊息列背景。",
    Desc_HideInFrames = "當游標移經人物頭像時隱藏訊息列。",

    -- TinyTipTargets
    Opt_Main_Targets= "目標訊息",
    Opt_TargetsTooltipUnit= "訊息列人物",
    Opt_TargetsParty= "小隊",
    Opt_TargetsRaid= "團隊",

    Map_TargetsTooltipUnit = {
        [1] = "在同一行顯示其目標",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "顯示每位玩家的名字",
        [2] = "Off" -- do not change
    },

    Desc_Main_Targets = "為人物訊息列添加目標的目標訊息。",
    Desc_TargetsTooltipUnit = "設定是否顯示訊息列對應人物的目標的名字。",
    Desc_TargetsParty = "設定關注訊息列對應人物的小隊隊友的顯示。",
    Desc_TargetsRaid = "設定關注訊息列對應人物的團隊隊友的顯示。",

    Opt_Profiles = "為每位人物單獨儲存設定",
    Desc_Profiles = "切換是否為每位人物单讀儲存設定。",

    Opt_Main_Default = "重置設定",
    Desc_Main_Default = "將插件設定重置為預設狀態。",

}, {__index=TinyTipOptionsLocale})

