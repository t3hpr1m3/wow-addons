--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


-- See http://wow.curseforge.com/addons/npcscan/localization/enUS/
select( 2, ... ).L = setmetatable( {
	NPCs = {
		[ 18684 ] = "Bro'Gaz the Clanless",
		[ 32491 ] = "Time-Lost Proto Drake",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
		[ 49822 ] = "Jadefang",
		[ 49913 ] = "Lady LaLa",
		[ 50005 ] = "Poseidus",
		[ 50009 ] = "Mobus",
		[ 50050 ] = "Shok'sharak",
		[ 50051 ] = "Ghostcrawler",
		[ 50052 ] = "Burgy Blackheart",
		[ 50053 ] = "Thartuk the Exile",
		[ 50056 ] = "Garr",
		[ 50057 ] = "Blazewing",
		[ 50058 ] = "Terrorpene",
		[ 50059 ] = "Golgarok",
		[ 50060 ] = "Terborus",
		[ 50061 ] = "Xariona",
		[ 50062 ] = "Aeonaxx",
		[ 50063 ] = "Akma'hat",
		[ 50064 ] = "Cyrus the Black",
		[ 50065 ] = "Armagedillo",
		[ 50085 ] = "Overlord Sunderfury",
		[ 50086 ] = "Tarvus the Vile",
		[ 50089 ] = "Julak-Doom",
		[ 50138 ] = "Karoma",
		[ 50154 ] = "Madexx (Brown)",
		[ 50159 ] = "Sambas",
		[ 50409 ] = "Mysterious Camel Figurine",
		[ 50410 ] = "Mysterious Camel Figurine",
		[ 50815 ] = "Skarr",
		[ 50959 ] = "Karkin",
		[ 51071 ] = "Captain Florence",
		[ 51079 ] = "Captain Foulwind",
		[ 51401 ] = "Madexx (Red)",
		[ 51402 ] = "Madexx (Green)",
		[ 51403 ] = "Madexx (Black)",
		[ 51404 ] = "Madexx (Blue)",
		[ 54318 ] = "Ankha",
		[ 54319 ] = "Magria",
		[ 54320 ] = "Ban'thalos",
		[ 54321 ] = "Solix",
		[ 54322 ] = "Deth'tilac",
		[ 54323 ] = "Kirix",
		[ 54324 ] = "Skitterflame",
		[ 54338 ] = "Anthriss",
	};

	BUTTON_FOUND = "NPC found!",
	CACHED_FORMAT = "The following unit(s) are already cached: %s.",
	CACHED_LONG_FORMAT = "The following unit(s) are already cached.  Consider removing them using |cff808080“/npcscan”|r's menu or resetting them by clearing your cache: %s.",
	CACHED_PET_RESTING_FORMAT = "The following tamable pet(s) were cached while resting: %s.",
	CACHED_STABLED_FORMAT = "The following unit(s) cannot be searched for while tamed: %s.",
	CACHED_WORLD_FORMAT = "The following %2$s unit(s) are already cached: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ", ",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "None of the mobs being searched for are cached.",
	CMD_HELP = "Commands are |cff808080“/npcscan add <NpcID> <Name>”|r, |cff808080“/npcscan remove <NpcID or Name>”|r, |cff808080“/npcscan cache”|r to list cached mobs, and simply |cff808080“/npcscan”|r for the options menu.",
	CMD_REMOVE = "REMOVE",
	CMD_REMOVENOTFOUND_FORMAT = "NPC |cff808080“%s”|r not found.",
	CONFIG_ALERT = "Alert Options",
	CONFIG_ALERT_SOUND = "Alert sound file",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Default|r",
	CONFIG_ALERT_SOUND_DESC = "Choose the alert sound to play when an NPC is found.  Additional sounds can be added through |cff808080“SharedMedia”|r addons.",
	CONFIG_ALERT_UNMUTE = "Unmute for alert sound",
	CONFIG_ALERT_UNMUTE_DESC = "Enables game sound while the targetting button is shown so you can hear alerts even while muted.",
	CONFIG_CACHEWARNINGS = "Print cache reminders on login and world changes",
	CONFIG_CACHEWARNINGS_DESC = "If an NPC is already cached when you log in or change worlds, this option prints a reminder of which chached mobs can't be searched for.",
	CONFIG_DESC = "These options let you configure the way _NPCScan alerts you when it finds rare NPCs.",
	CONFIG_PRINTTIME = "Print timestamps to chat frame",
	CONFIG_PRINTTIME_DESC = "Adds the current time to all printed messages.  Useful for recording when NPCs were found.",
	CONFIG_TEST = "Test Found Alert",
	CONFIG_TEST_DESC = "Simulates an |cff808080“NPC found”|r alert to let you know what to look out for.",
	CONFIG_TEST_HELP_FORMAT = "Click the target button or use the provided keybinding to target the found mob.  Hold |cffffffff<%s>|r and drag to move the target button.  Note that if an NPC is found while you're in combat, the button will only appear after you exit combat.",
	CONFIG_TEST_NAME = "You! (Test)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "Found |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "Found |cff808080“%s”|r!  |cffff2020(Note: Tamable mob, may only be a pet.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020False alarm:|r Found tamable mob |cff808080“%s”|r in %s instead of %s (ID %d); Definitely a pet.",
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Search for completed Achievement NPCs",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continues searching for all achievement NPCs, even if you no longer need them.",
	SEARCH_ACHIEVEMENT_DISABLED = "Disabled",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Add new NPC or save changes to existing one.",
	SEARCH_ADD_TAMABLE_FORMAT = "Note: |cff808080“%s”|r is tamable, so seeing it as a tamed hunter's pet will cause a false alarm.",
	SEARCH_CACHED = "Cached",
	SEARCH_COMPLETED = "Done",
	SEARCH_DESC = "This table allows you to add or remove NPCs and achievements to scan for.",
	SEARCH_ID = "NPC ID:",
	SEARCH_ID_DESC = "The ID of the NPC to search for.  This value can be found on sites like Wowhead.com.",
	SEARCH_MAP = "Zone:",
	SEARCH_NAME = "Name:",
	SEARCH_NAME_DESC = "A label for the NPC.  It doesn't have to match the NPC's actual name.",
	SEARCH_NPCS = "Custom NPCs",
	SEARCH_NPCS_DESC = "Add any NPC to track, even if it has no achievement.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Search",
	SEARCH_WORLD = "World:",
	SEARCH_WORLD_DESC = "An optional world name to limit searching to.  Can be a continent name or |cffff7f3finstance name|r (case-sensitive).",
	SEARCH_WORLD_FORMAT = "(%s)",
	TIME_FORMAT = "|cff808080[%H:%M:%S]|r ",

	-- Phrases localized by default UI
	FOUND_ZONE_UNKNOWN = UNKNOWN;
	SEARCH_LEVEL_TYPE_FORMAT = UNIT_TYPE_LEVEL_TEMPLATE; -- Level, Type
}, {
	__index = function ( self, Key )
		if ( Key ~= nil ) then
			rawset( self, Key, Key );
			return Key;
		end
	end;
} );


SLASH__NPCSCAN1 = "/npcscan";
SLASH__NPCSCAN2 = "/scan";

BINDING_HEADER__NPCSCAN = "_|cffCCCC88NPCScan|r";
_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Target last found mob
|cff808080(Use when _NPCScan alerts you)|r]=];