--[[-------------------------------------------------------
-- TinyTipOptions Localization : German
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
-- Contributors: Gamefaq
--]]

if GetLocale() ~= "deDE" then return end

TinyTipOptionsLocale = setmetatable({
    On = "An",
    Off = "Aus",
    GameDefault = "WoW Grundeinstellung",
    TinyTipDefault = "TinyTip's Grundeinstellung",

    -- TinyTip Positioning
    Opt_Main_Anchor = "Tooltip Grundposition",
    Opt_MAnchor = "Spieler Position",
    Opt_FAnchor = "Fenster Position",
    Opt_MOffX = "Spieler Position waagerechte [X-Achse]",
    Opt_MOffY = "Spieler Position senkrechte [Y-Achse]",
    Opt_FOffX = "Fenster Position waagerechte [X-Achse]",
    Opt_FOffY = "Fenster Position senkrechte [Y-Achse]",

    Map_Anchor = {
        ["LEFT"] = "LINKS",
        ["RIGHT"] = "RECHTS",
        ["BOTTOMRIGHT"] = "UNTENRECHTS",
        ["BOTTOMLEFT"] = "UNTENLINKS",
        ["BOTTOM"] = "UNTEN",
        ["TOP"] = "OBEN",
        ["TOPLEFT"]  = "OBENLINKS",
        ["TOPRIGHT"] = "OBENRECHTS",
        ["CENTER"] = "MITTE"
    },

    CURSOR = "CURSOR",
    SMART = "INTELLIGENT",

    Desc_Main_Anchor = "Justiert die Tooltip Position.",
    Desc_MAnchor = "Justiert die Position für den Tooltip wenn man mit dem Mausecourser über andere Spieler im Hauptfenster geht.",
    Desc_FAnchor = "Justiert die Position des Tooltips wenn man über ein BELIBIGES Fenster mit dem Mauscourser geht ein (außer das Hauptfenster).",
    Desc_MOffX = "Justiert die horinzontale Position des Tooptips ein für den Fixpunkt der Spieler.",
    Desc_MOffY = "Justiert die vertikale Position des Tooltips für den Fixpunkt der Spieler.",
    Desc_FOffX = "Justiert die waagerechte Position des Tooltips ausgehend vom Fixpunkt für ALLE Fenster.",
    Desc_FOffY = "Justiert die senkrechte Position des Tooltips ausgehend vom Fixpunkt für ALLE Fenster.",

    -- TinyTipBasic
    Opt_HideRace = "Verstecke Rassen Text",
    Opt_HideNPCType = "Verstecke NPC Typen Text",
    Opt_KeyElite = "Benutze Rar/Elite Markierung",
    Opt_PvPRankText = "PvP Rang",
    Opt_LevelGuess = "Verstecke Levelnangabe",
    Opt_ReactionText = "Zeige Reaktionstext",
    Opt_KeyServer = "Anzeigen von (*) anstelle des Server Namens",

    Desc_Main_Text = "Stellt ein was im Spieler Tooltip angezeigt wird.",
    Desc_HideRace = "Spieler Rasse anzeigen?",
    Desc_HideNPCType = "Spieler Monster Typ anzeigen?",
    Desc_KeyElite = "Anzeigeart ++ für Elite, + für Rare, +++ für Rare Elite, und (!) für Welt Boss.",
    Desc_PvPRankText = "Stelle die Optionen ein um den PVP Rang in Textform anzuzeigen.",
    Desc_ReactionText = "Reaktionstext der Ziele anzeigen ? (Freundlich, Feindlich, usw.)",
    Desc_LevelGuess = "Anzeige umschalten (Dein Level +10) anstelle von ?? für unbekannte Gegner Level?",
    Desc_KeyServer = "Anzeigen von (*) neben den Spieler Namen, wenn sie von einem anderen Server stammen anstatt den Server Namen anzuzeigen.",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance = "Aussehen",
    Opt_Scale = "Skalierung",
    Opt_BGColor = "Hintergrund Optionen",
    Opt_Border = "Rand Optionen",
    Opt_ColourFriends = "Farbton für Freunde und Gildenkollegen",
    Opt_HideInFrames = "Verstecke Tooltips von Spieler Fenstern",
    Opt_HideInCombat = "Verstecke Tooltips von Spieler Kampf",

    Map_PvPRankText = {
        [1] = "Zeige Rang Nummer nach dem Namen",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "Färbe NPCs wie PCs",
        [3] = "Immer Schwarz",
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "Verstecke Rahmen",
    },

    Map_ColourFriends = {
        [1] = "Färbe nur Namen",
        [2] = "Kein einfärben"
    },

    Desc_Main_Appearance = "Stellt Aussehen und Verhalten des Tooltips ein.",
    Desc_Scale =  "Stellt die Skalierung des Tooltips und eventuell angehefter Icons ein.",
    Desc_BGColor = "Stellt die Farben des Tooltip Hintergunds ein.",
    Desc_Border = "Stellt die Farben für den Tooltipramen ein.",
    Desc_ColourFriends = "Namen und Hintegrund anders einfärben als von Freunden?",
    Desc_HideInFrames = "Verstecke den Tooltip von Interface Fenstern (Party/Schachtgruppe/Ziel) die zu Spielern gehören, wenn man mit dem Mauscourser über sie geht.",

    -- TinyTipTargets
    Opt_Main_Targets = "Ziel von ...",
    Opt_TargetsTooltipUnit = "Spieler Tooltip's ",
    Opt_TargetsParty = "Spieler Tooltip's ",
    Opt_TargetsRaid = "Raid",

    Map_TargetsTooltipUnit = {
        [1] = "Zeige Ziel des Spielers in der gleichen Spalte wie seinen Namen",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "Zeige alle Namen",
        [2] = "Off" -- do not change
    },

    Main_Targets = "Zeigt das Ziel des eigenen Ziels auch im Tooltip an.",
    Desc_TargetsTooltipUnit = "Stellt ein ob man den Namen des Ziels, vom eigenen Ziel angezeigt haben möchte.",
    Desc_TargetsParty =  "Anzeigen ob jemand anderes aus deiner Gruppe, dein Ziel auch angeklickt hat.",
    Desc_TargetsRaid = "Anzeigen ob jemand anderes aus deiner Schlachtgruppe, dein Ziel auch angeklickt hat.",

    Opt_Profiles = "Speichere die Einstellungen pro Charakter",
    Desc_Profiles = "Setzt die Einstellungen zurrück auf die Grundeinstellungen.",

    Opt_Main_Default = "Optionen zurücksetzen",
    Desc_Main_Default = "Return this addon's settings back to their defaults.",
}, {__index=TinyTipOptionsLocale})

