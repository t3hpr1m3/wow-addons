﻿local revision = tonumber(string.sub("$Revision: 126 $", 12, -3)) or 1
if revision > ElkBuffBars.revision then ElkBuffBars.revision = revision end

local L = AceLibrary("AceLocale-2.2"):new("ElkBuffBars")

L:RegisterTranslations("deDE", function() return {
	TOOLTIP_BARGROUP = "Balkengruppe",
	TOOLTIP_TYPE = "Typ",
	
	OPTIONS_OVERRIDES_NAME = "Überschreibungs-Einstellungen",
	OPTIONS_OVERRIDES_DESC = "Typ und Namen von bekannten Buffs ändern",
	OPTIONS_OVERRIDES_NAME_NAME = "Angezeigter Name",
	OPTIONS_OVERRIDES_NAME_DESC = "Namen der angezeigt wird",
	OPTIONS_OVERRIDES_TYPE_NAME = "Neuer Typ",
	OPTIONS_OVERRIDES_TYPE_DESC = "Setzt den neuen Typ",
	OPTIONS_OVERRIDES_TYPE_VALIDATE_DEFAULT = "Standard",
	OPTIONS_BARGROUPS_NAME = "Gruppen-Einstellungen",
	OPTIONS_BARGROUPS_DESC = "Ändert die Einstellungen für die Balkengruppen",
	OPTIONS_NEWGROUP_NAME = "Neue Gruppe",
	OPTIONS_NEWGROUP_DESC = "Neue Balkengruppe erstellen",
	OPTIONS_GROUPSPACING_NAME = "Gruppen-Abstand",
	OPTIONS_GROUPSPACING_DESC = "Setzt den Abstand zwischen verankterten Gruppen",
	OPTIONS_HIDEBLIZZARDBUFFS_NAME = "Verstecke Blizzard Buff-Anzeige",
	OPTIONS_HIDEBLIZZARDBUFFS_DESC = "Schaltet das Anzeigen der Blizzard Buff-Anzeige um",
	OPTIONS_HIDEBLIZZARDTENCH_NAME = "Verstecke Blizzard TEnch-Anzeige",
	OPTIONS_HIDEBLIZZARDTENCH_DESC = "Schaltet das Anzeigen der Blizzard TEnch-Anzeige um",
	OPTIONS_HIDEBLIZZARDTRACKING_NAME = "Versteckt die Minimap-Anzeige",
	OPTIONS_HIDEBLIZZARDTRACKING_DESC = "Schaltet das Anzeigen der Minimap-Anzeige um",
	OPTIONS_GROUP_NAME = "Gruppe %d",
	OPTIONS_GROUP_DESC = "Einstellungen für Gruppe %d",
--	OPTIONS_GROUP_CONFIG_NAME = "Configuration Mode",
--	OPTIONS_GROUP_CONFIG_DESC = "Toggles configuration mode",
	OPTIONS_GROUP_ANCHOR_NAME = "Anker zeigen",
	OPTIONS_GROUP_ANCHOR_DESC = "Schaltet die Anzeige des Ankers um",
	OPTIONS_GROUP_NAME_NAME = "Name",
	OPTIONS_GROUP_NAME_DESC = "Setzt den Gruppen-Name",
	OPTIONS_GROUP_BARLAYOUT_NAME = "Balkenaussehen",
	OPTIONS_GROUP_BARLAYOUT_DESC = "Setzt die Aussehen der Balkengruppe",
	OPTIONS_GROUP_BAR_NAME = "Balken",
	OPTIONS_GROUP_BAR_DESC = "Einstellungen für die Statusanzeige",
	OPTIONS_GROUP_BAR_SHOW_NAME = "Statusanzeige anzeigen",
	OPTIONS_GROUP_BAR_SHOW_DESC = "Schaltet die Anzeige der Statusanzeige um",
	OPTIONS_GROUP_BAR_TEXTURE_NAME = "Balkentextur",
	OPTIONS_GROUP_BAR_TEXTURE_DESC = "Setzt die Balkentextur",
	OPTIONS_GROUP_BAR_COLOR_NAME = "Balkenfarbe",
	OPTIONS_GROUP_BAR_COLOR_DESC = "Setzt die Balkenfarbe",
	OPTIONS_GROUP_BAR_BGSHOW_NAME = "Hintergrund zeigen",
	OPTIONS_GROUP_BAR_BGSHOW_DESC = "Schaltet die Anzeige des Balkenhintergrunds um",
	OPTIONS_GROUP_BAR_BGCOLOR_NAME = "Hintergrundfarbe",
	OPTIONS_GROUP_BAR_BGCOLOR_DESC = "Setzt die Farbe für den Balkenhintergrund",
	OPTIONS_GROUP_BAR_SPARK_NAME = "Funke",
	OPTIONS_GROUP_BAR_SPARK_DESC = "Schaltet die Anzeige des Funkens um",
	OPTIONS_GROUP_BAR_DEBUFFCOLOR_NAME = "Debuff-Farbe",
	OPTIONS_GROUP_BAR_DEBUFFCOLOR_DESC = "Schaltet um, ob der Balken je nach Debuff-Typ eingefärbt wird",
	OPTIONS_GROUP_BAR_LTRDIR_NAME = "Balkenrichtung LNR",
	OPTIONS_GROUP_BAR_LTRDIR_DESC = "Schaltet die Wachstumsrichtung der Balken um",
	OPTIONS_GROUP_BAR_TIMELESSFULL_NAME = "Volle Balken für zeitlose Buffs",
	OPTIONS_GROUP_BAR_TIMELESSFULL_DESC = "Schaltet die vollen Balken für zeitlose Buffs um",
	OPTIONS_GROUP_ICON_NAME = "Symbol",
	OPTIONS_GROUP_ICON_DESC = "Einstellungen für das Symbol",
	OPTIONS_GROUP_ICON_POSITION_NAME = "Position",
	OPTIONS_GROUP_ICON_POSITION_DESC = "Setzt die Anzeige des Symbols",
	OPTIONS_GROUP_ICON_POSITION_HIDE = "versteckt",
	OPTIONS_GROUP_ICON_POSITION_LEFT = "Linke Seite",
	OPTIONS_GROUP_ICON_POSITION_RIGHT = "Rechte Seite",
	OPTIONS_GROUP_ICON_STACK_SHOW_NAME = "Buff-Stapel - Anzeige",
	OPTIONS_GROUP_ICON_STACK_SHOW_DESC = "Schaltet um ob Stapel bei Buffs gezeigt werden",
	OPTIONS_GROUP_ICON_STACK_ANCHOR_NAME = "Buff-Stapel - Anker",
	OPTIONS_GROUP_ICON_STACK_ANCHOR_DESC = "Setzt den Anker der Buff-Stapel",
	OPTIONS_GROUP_ICON_STACK_FONT_NAME = "Buff-Stapel - Schrift",
	OPTIONS_GROUP_ICON_STACK_FONT_DESC = "Setzt die Schrift der Buff-Stapel",
	OPTIONS_GROUP_ICON_STACK_FONTSIZE_NAME = "Buff-Stapel - Schriftgröße",
	OPTIONS_GROUP_ICON_STACK_FONTSIZE_DESC = "Setzt die Schriftgröße der Buff-Stapel",
	OPTIONS_GROUP_ICON_STACK_FONTCOLOR_NAME = "Buff-Stapel - Schriftfarbe",
	OPTIONS_GROUP_ICON_STACK_FONTCOLOR_DESC = "Setzt die Schriftfarbe der Buff-Stapel",
	OPTIONS_GROUP_TEXTTL_NAME = "Text obenlinks",
	OPTIONS_GROUP_TEXTTL_DESC = "Einstellungen für den Text obenlinks",
	OPTIONS_GROUP_TEXTTR_NAME = "Text obenrechts",
	OPTIONS_GROUP_TEXTTR_DESC = "Einstellungen für den Text obenrechts",
	OPTIONS_GROUP_TEXTBL_NAME = "Text untenlinks",
	OPTIONS_GROUP_TEXTBL_DESC = "Einstellungen für den Text untenlinks",
	OPTIONS_GROUP_TEXTBR_NAME = "Text untenrechts",
	OPTIONS_GROUP_TEXTBR_DESC = "Einstellungen für den Text untenrechts",
	OPTIONS_GROUP_TEXT_TEMPLATE_NAME = "Angezeigter Text",
	OPTIONS_GROUP_TEXT_TEMPLATE_DESC = "Setzt den Text, der angezeigt wird",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_HIDE = "Versteckt",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_NAME = "Name",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_NAMERANK = "Name, Rank",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_NAMECOUNT = "Name, Anzahl",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_NAMERANKCOUNT = "Name, Rank, Anzahl",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_RANK = "Rank",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_COUNT = "Anzahl",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_TIMELEFT = "verbleibende Zeit",
	OPTIONS_GROUP_TEXT_TEMPLATE_OPTION_DEBUFFTYPE = "Debuff-Typ",
	OPTIONS_GROUP_TEXT_FONT_NAME = "Schrift",
	OPTIONS_GROUP_TEXT_FONT_DESC = "Setzt die Schrift",
	OPTIONS_GROUP_TEXT_FONTSIZE_NAME = "Schriftgröße",
	OPTIONS_GROUP_TEXT_FONTSIZE_DESC = "Setzt die Schriftgröße",
	OPTIONS_GROUP_TEXT_FONTCOLOR_NAME = "Schriftfarbe",
	OPTIONS_GROUP_TEXT_FONTCOLOR_DESC = "Setzt die Schriftfarbe",
	OPTIONS_GROUP_TEXT_ALIGNMENT_NAME = "Anordnung",
	OPTIONS_GROUP_TEXT_ALIGNMENT_LEFT = "links",
	OPTIONS_GROUP_TEXT_ALIGNMENT_CENTER = "Mitte",
	OPTIONS_GROUP_TEXT_ALIGNMENT_RIGHT = "rechts",
	OPTIONS_GROUP_TEXTTL_ALIGNMENT_DESC = "Setzt die Textausrichtung (nur wenn Text obenrechts versteckt)",
	OPTIONS_GROUP_TEXTBL_ALIGNMENT_DESC = "Setzt die Textausrichtung (nur wenn Text untenrechts versteckt)",
	OPTIONS_GROUP_ABBREVIATE_NAME = "Namen abkürzen",
	OPTIONS_GROUP_ABBREVIATE_DESC = "Namen kürzen wenn länger als (0 = nie)",
	OPTIONS_GROUP_TIMEFORMAT_NAME = "Zeitformat",
	OPTIONS_GROUP_TIMEFORMAT_DESC = "Setzt das Zeitformat",
	OPTIONS_GROUP_PADDING_NAME = "Innenabstand",
	OPTIONS_GROUP_PADDING_DESC = "Setzt den Innenabstand für Text",
	OPTIONS_GROUP_TTIPANCHOR_NAME = "Tooltipp-Anker",
	OPTIONS_GROUP_TTIPANCHOR_DESC = "Setzt den Anker für Tooltipps",
	OPTIONS_GROUP_HEIGHT_NAME = "Höhe",
	OPTIONS_GROUP_HEIGHT_DESC = "Setzt die Balkenhöhe",
	OPTIONS_GROUP_WIDTH_NAME = "Breite",
	OPTIONS_GROUP_WIDTH_DESC = "Setzt die Balkenbreite",
	OPTIONS_GROUP_ALPHA_NAME = "Transparenz",
	OPTIONS_GROUP_ALPHA_DESC = "Setzt die Balkentransparenz",
	OPTIONS_GROUP_SCALE_NAME = "Skalierung",
	OPTIONS_GROUP_SCALE_DESC = "Setzt die Skalierung der Balkengruppe",
	OPTIONS_GROUP_BARSPACING_NAME = "Balkenabstand",
	OPTIONS_GROUP_BARSPACING_DESC = "Setzt den Balkenabstand",
	OPTIONS_GROUP_GROWUP_NAME = "nach oben wachsen",
	OPTIONS_GROUP_GROWUP_DESC = "Schaltet die Wachstumsrichtung der Buffs um",
	OPTIONS_GROUP_SORTING_NAME = "Sortieren",
	OPTIONS_GROUP_SORTING_DESC = "Setzt, wie die Buffs sortiert werden",
	OPTIONS_GROUP_FILTER_NAME = "Filter",
	OPTIONS_GROUP_FILTER_DESC = "Stellt die zu zeigenden Buffs ein",
	OPTIONS_GROUP_FILTER_TYPE_NAME = "Typ",
	OPTIONS_GROUP_FILTER_TYPE_DESC = "Welcher Typ von Buff angezeigt wird",
	OPTIONS_GROUP_FILTER_SELFCAST_NAME = "Selbst gewirkte Buffs",
	OPTIONS_GROUP_FILTER_SELFCAST_DESC = "Setzt ob und wie selbst gewirkte Buffs gezeigt werden",
	OPTIONS_GROUP_FILTER_SELFCAST_VALIDATE_NOFILTER = "nicht filtern",
	OPTIONS_GROUP_FILTER_SELFCAST_VALIDATE_WHITELIST = "whitelist",
	OPTIONS_GROUP_FILTER_SELFCAST_VALIDATE_BLACKLIST = "blacklist",
	OPTIONS_GROUP_FILTER_TIMELESS_NAME = "Buffs ohne Zeit",
	OPTIONS_GROUP_FILTER_TIMELESS_DESC = "Setzt ob und wie Buffs ohne Zeit gefilter werden",
	OPTIONS_GROUP_FILTER_TIMELESS_VALIDATE_NOFILTER = "nicht filtern",
	OPTIONS_GROUP_FILTER_TIMELESS_VALIDATE_WHITELIST = "whitelist",
	OPTIONS_GROUP_FILTER_TIMELESS_VALIDATE_BLACKLIST = "blacklist",
	OPTIONS_GROUP_FILTER_TIMEMAXMIN_NAME = "Min. Zeit",
	OPTIONS_GROUP_FILTER_TIMEMAXMIN_DESC = "Setzt eine Min. Zeit, ab der Buffs gezeigt werden",
	OPTIONS_GROUP_FILTER_TIMEMAXMIN_USAGE = "Zeit in Sekunden",
	OPTIONS_GROUP_FILTER_TIMEMAXMAX_NAME = "Max. Zeit",
	OPTIONS_GROUP_FILTER_TIMEMAXMAX_DESC = "Setzt eine Max. Zeit, bis zu der Buffs gezeigt werden.",
	OPTIONS_GROUP_FILTER_TIMEMAXMAX_USAGE = "Zeit in Sekunden",
	OPTIONS_GROUP_FILTER_NAME_WHITELIST_NAME = "White List",
	OPTIONS_GROUP_FILTER_NAME_WHITELIST_DESC = "Nur Buffs auf der Whitelist zeigen (inaktiv wenn leer)",
	OPTIONS_GROUP_FILTER_NAME_BLACKLIST_NAME = "Black List",
	OPTIONS_GROUP_FILTER_NAME_BLACKLIST_DESC = "Buffs auf der Blacklist werden nicht gezeigt",
	OPTIONS_GROUP_TARGET_NAME = "Ziel",
	OPTIONS_GROUP_TARGET_DESC = "Setzt wessen Buffs gezeigt werden",
	OPTIONS_GROUP_CLICKTHROUGH_NAME = "Maus abschalten",
	OPTIONS_GROUP_CLICKTHROUGH_DESC = "Maus abschalten, um Hindurch-Klicken zu Erlauben",
	OPTIONS_GROUP_COPYLAYOUT_NAME = "Layout kopieren",
	OPTIONS_GROUP_COPYLAYOUT_DESC = "Kopiert das Layout einer anderen Gruppe",
	OPTIONS_GROUP_COPYLAYOUT_USAGE = "ID der Gruppe",
	OPTIONS_GROUP_RESETPOSITION_NAME = "Position zurücksetzen",
	OPTIONS_GROUP_RESETPOSITION_DESC = "Position der Balkengruppe auf Bildschirmmitte zurücksetzen",
	OPTIONS_GROUP_REMOVE_NAME = "Gruppe entfernen",
	OPTIONS_GROUP_REMOVE_DESC = "Entfernt die Gruppe",
	
	CHATCOMMAND_CONFIG_DESC = "Zeigt das Konfigurations-Menü",
}end)
