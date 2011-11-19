--[[-------------------------------------------------------
-- TinyTipOptions Localization : English (Default)
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
--]]

TinyTipOptionsLocale = {
    Requires = "requires",
    On = "On",
    Off = "Off",
    GameDefault = "Game's Default",
    TinyTipDefault = "TinyTip's Default",

    -- TinyTip Positioning
    Opt_Main_Anchor = "Anchoring",
    Opt_MAnchor = "Unit Anchor",
    Opt_FAnchor = "Frame Anchor",
    Opt_MOffX = "Unit Offset [X]",
    Opt_MOffY = "Unit Offset [Y]",
    Opt_FOffX = "Frame Offset [X]",
    Opt_FOffY = "Frame Offset [Y]",

    Map_Anchor = {
        ["LEFT"] = "LEFT",
        ["RIGHT"] = "RIGHT",
        ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
        ["BOTTOMLEFT"] = "BOTTOMLEFT",
        ["BOTTOM"] = "BOTTOM",
        ["TOP"] = "TOP",
        ["TOPLEFT"]  = "TOPLEFT",
        ["TOPRIGHT"] = "TOPRIGHT",
        ["CENTER"] = "CENTER"
    },

    CURSOR = "CURSOR",
    SMART = "SMART",

    Desc_Main_Anchor = "Set the tooltip's positioning.",
    Desc_MAnchor = "Set the anchor for the tooltip when mousing over units in the world frame.",
    Desc_FAnchor = "Set the anchor for the tooltip when mousing over ANY frame (except the WorldFrame).",
    Desc_MOffX = "Set the horizontal offset from the anchor point for units.",
    Desc_MOffY = "Set the vertical offset from the anchor point for units.",
    Desc_FOffX = "Set the horizontal offset from the anchor point when mousing over ANY frame.",
    Desc_FOffY = "Set the vertical offset from the anchor point when mousing over ANY frame.",

    -- TinyTipBasic
    Opt_Main_Text = "Text Formating",
    Opt_HideRace = "Hide Player Race",
    Opt_HideNPCType = "Hide NPC Type",
    Opt_KeyElite = "Use Classification Keys",
    Opt_PvPRankText = "PvP Rank",
    Opt_LevelGuess = "Level Guestimate",
    Opt_ReactionText = "Show Reaction Text",
    Opt_KeyServer = "Display (*) instead of Server/Realm Name",

    Desc_Main_Text = "Change what text is displayed inside the unit tooltip.",
    Desc_HideRace = "Toggle whether to hide a player's race.",
    Desc_HideNPCType = "Toggle whether to hide a NPC or pet's type.",
    Desc_KeyElite = "Use + for Rare, ++ for Elite, +++ for Rare Elite, and (!) for World Boss.",
    Desc_PvPRankText = "Set the options for the PvP Rank to be shown in text.",
    Desc_ReactionText = "Toggle whether to show the reaction text (Friendly, Hostile, etc.)",
    Desc_LevelGuess = "Toggle whether to show >(Your Level +10) instead of ?? for unknown levels.",
    Desc_KeyServer = "Display (*) next to the unit's name if they are from a different server instead of printing out the server name.",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance = "Appearance",
    Opt_Scale = "Scale",
    Opt_BGColor = "Backdrop Coloring",
    Opt_Border = "Border Coloring",
    Opt_ColourFriends = "Coloring For Friends",
    Opt_HideInFrames = "Hide Tooltip For Unit Frames",
    Opt_HideInCombat = "Hide Tooltip In Combat",

    Map_PvPRankText = {
        [1] = "Show Rank Number after Name",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "Color NPCs like PCs",
        [3] = "Always Black",
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "Hide Border",
    },

    Map_ColourFriends = {
        [1] = "Color Only Name",
        [2] = "Don't Color"
    },

    Desc_Main_Appearance = "Set the look and behavior of the tooltip.",
    Desc_Scale =  "Set the scale of the tooltip (and attached icons).",
    Desc_BGColor = "Set the color scheme for the unit tooltip's backdrop.",
    Desc_Border = "Set the color scheme for the unit tooltip's border.",
    Desc_ColourFriends = "Set whether to color the backdrop or name differently for friends.",
    Desc_HideInFrames = "Hide the tooltip while mousing over unit frames.",
    Desc_HideInCombat = "Hide the tooltip while in combat.",

    -- TinyTipTargets
    Opt_Main_Targets = "Target Of ...",
    Opt_TargetsTooltipUnit = "Tooltip's Unit",
    Opt_TargetsParty = "Party",
    Opt_TargetsRaid = "Raid",
    Opt_TargetsNoEventUpdate = "Disable dynamic updating",

    Map_TargetsTooltipUnit = {
        [1] = "Show Target On Same Line As UnitName",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "Show Each Name",
        [2] = "Off" -- do not change
    },

    Map_TargetsRaid = {
        [1] = "Off", -- do not change
    },

    Main_Targets = "Add who's targeting what in the information to the unit tooltip.",
    Desc_TargetsTooltipUnit = "Set whether to show the name of tooltip unit's target.",
    Desc_TargetsParty = "Set the options for seeing if anyone in your party is targeting the tooltip's unit.",
    Desc_TargetsRaid = "Set the options for seeing if anyone in your raid is targeting the tooltip's unit.",
    Desc_TargetsNoEventUpdate = "Disable dynamic updating, meaning the targets will only update when you initially mouseover the unit.",

    Opt_Profiles = "Save Settings Per Character",
    Desc_Profiles = "Toggle whether to save your settings per character or globally.",

    Opt_Main_Default = "Reset Options",
    Desc_Main_Default = "Return this addon's settings back to their defaults.",
    ResetDB_Confirm = "Are you SURE you want to return your settings to their default values?",

    Main_General = "General",
    WhatIsTinyTip = "Provides reformatting of the default unit tooltip, as well as extra information and more. It's what Thrae wants in a tooltip.",
}

