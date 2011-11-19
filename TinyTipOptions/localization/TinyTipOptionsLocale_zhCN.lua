--[[-------------------------------------------------------
-- TinyTipOptions Localization : Chinese (Simplified)
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
-- Contributors: hk2717 , Isler
--]]

if GetLocale() ~= "zhCN" then return end

TinyTipOptionsLocale = setmetatable({
    On = "开启",
    Off = "关闭",
    GameDefault = "游戏默认",
    TinyTipDefault = "TinyTip默认",

    -- TinyTipPositioning
    Opt_Main_Anchor= "锚点",
    Opt_MAnchor= "人物信息条锚点",
    Opt_FAnchor= "框体信息条锚点",
    Opt_MOffX= "人物信息条偏移量[X]",
    Opt_MOffY= "人物信息条偏移量[Y]",
    Opt_FOffX= "框体信息条偏移量[X]",
    Opt_FOffY= "框体信息条偏移量[Y]",

    Map_Anchor = {
        ["LEFT"] = "左端",
        ["RIGHT"] = "右端",
        ["BOTTOMRIGHT"] = "右下角",
        ["BOTTOMLEFT"] = "左下角",
        ["BOTTOM"] = "底端",
        ["TOP"] = "顶端",
        ["TOPLEFT"] = "左上角",
        ["TOPRIGHT"] = "右上角",
        ["CENTER"] = "中央"
    },

    CURSOR = "鼠标",
    SMART = "智能",

    Desc_Main_Anchor = "设置信息条位置。",
    Desc_MAnchor = "设置鼠标移经人物时显示的信息条的锚点位置 。",
    Desc_FAnchor = "设置鼠标移经任何框体时显示的信息条的锚点位置。（世界框体除外）",
    Desc_MOffX = "设置人物信息条相对于锚点的水平偏移量。",
    Desc_MOffY = "设置人物信息条相对于锚点的垂直偏移量。",
    Desc_FOffX = "设置框体信息条相对于锚点的水平偏移量。",
    Desc_FOffY = "设置框体信息条相对于锚点的垂直偏移量。",

    -- TinyTipBasic
    Opt_Main_Text= "文本",
    Opt_HideRace = "隐藏职业和生物类型信息",
    Opt_HideNPCType = "隐藏 NPC 类型信息",
    Opt_KeyElite = "启用分类标识",
    Opt_PvPRankText = "军衔信息",
    Opt_LevelGuess = "猜测等级",
    Opt_ReactionText = "显示声望信息",
    Opt_KeyServer = "用 (*) 代替服务器名称",

    Desc_Main_Text = "设置人物信息条中显示的文本信息。",
    Desc_HideRace = "切换是否隐藏玩家职业和生物类型信息。",
    Desc_HideNPCType = "切换是否隐藏 NPC 或 pet 的类型.",
    Desc_KeyElite = "以*标识精英生物，以!标识稀有生物，以!*标识稀有精英生物，以**标识世界首领。",
    Desc_PvPRankText = "设置军衔信息显示方式。",
    Desc_ReactionText = "切换是否显示声望信息。（友好，敌对等等。）",
    Desc_LevelGuess = "切换是以(你的等级 +10)还是以??显示等级高出你10级以上的生物。",
    Desc_KeyServer = "当玩家来自不同服务器时，在他们的名字后面显示 (*)，而不显示他的服务器名称。",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance= "外观",
    Opt_Scale= "缩放",
    Opt_BGColor= "背景颜色",
    Opt_Border= "边框颜色",
    Opt_ColourFriends= "以特别的颜色显示好友和同公会成员",
    Opt_HideInFrames= "隐藏人物头像信息条",
    Opt_HideInCombat = "在战斗中隐藏鼠标提示",

    Map_PvPRankText = {
        [1] =  "在名字后面显示军衔名",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "以玩家方式显示NPC",
        [3] = "总是黑色"
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "隐藏边框",
    },

    Map_ColourFriends = {
        [1] = "只对名字上色",
        [2] = "不上色",
    },

    Desc_Main_Appearance = "设置信息条外观与行为。",
    Desc_Scale =  "设置信息条的缩放比例。（包括附带的图标）",
    Desc_BGColor = "设置人物信息条背景的颜色方案。",
    Desc_Border = "设置人物信息条边框的颜色方案。",
    Desc_ColourFriends = "设置是否使用特别的颜色显示好友和同公会成员的名字或信息条背景。",
    Desc_HideInFrames = "当鼠标移经人物头像时隐藏信息条。",
    Desc_HideInCombat = "在战斗中隐藏鼠标提示.",

    -- TinyTipTargets
    Opt_Main_Targets = "目标信息",
    Opt_TargetsTooltipUnit = "信息条人物",
    Opt_TargetsParty = "小队",
    Opt_TargetsRaid = "团队",

    Map_TargetsTooltipUnit = {
        [1] = "在同一行显示其目标",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "显示每个玩家的名字",
        [2] = "Off" -- do not change
    },

    Map_TargetsRaid = {
        [1] = "Off", -- do not change
    },

    Main_Targets = "给人物信息条添加目标的目标信息。",
    Desc_TargetsTooltipUnit = "设置是否显示信息条对应人物的目标的名字。",
    Desc_TargetsParty = "设置关注信息条对应人物的小队对友的显示。",
    Desc_TargetsRaid = "设置关注信息条对应人物的团队对友的显示。",

    Opt_Profiles = "为每个人物单独保存设置",
    Desc_Profiles = "切换是否为每个人物单独保存设置。",

    Opt_Main_Default = "重置设置",
    Desc_Main_Default = "将插件设置重置为默认状态。",

}, {__index=TinyTipOptionsLocale})

