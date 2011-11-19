-- Deutsche
--				  lower		 upper
-- a umlaut	  \195\164	 \195\132
-- o umlaut	  \195\182	 \195\150
-- u umlaut	  \195\188	 \195\156
-- sharp s	  \195\159
-- � = \195\164 -- � = \195\132 
-- � = \195\182 -- � = \195\150 
-- � = \195\188 -- � = \195\156 
-- � = \195\159


FishingTranslations["deDE"] = {
	ABOUT_TAB = "\195\156ber", -- Needs review
	ADD = "hinzuf\195\188gen",
	ADDFISHIEMSG = "%s zum Standort %s hinzuf\195\188gen.",
	ADDSCHOOLMSG = "'%s' zum Standort %s hinzuf\195\188gen.",
	ALLZOMGPETS = "Schlie\195\159t alle Haustiere ein", -- Needs review
	BINDING_NAME_FISHINGBUDDY_GOFISHING = "Anziehen und angeln gehen",
	BINDING_NAME_FISHINGBUDDY_SWITCH = "Angelausr\195\188stung wechseln",
	BINDING_NAME_FISHINGBUDDY_TOGGLE = "#NAME# Fenster umschalten",
	BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "#NAME# Standortfeld umschalten",
	BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "#NAME# Optionsfeld umschalten",
	BOBBER_NAME = "Angelblinker",
	CAST = "auswerfen",
	CAUGHTTHISMANY = "Gefangen:",
	CAUGHTTHISTOTAL = "Insgesamt:",
	CAUGHT_IN_ZONES = "Gefangen in: %s",
	CHECK = "pr\195\188fe",
	CLEANUP = "bereinigen",
	CLEANUP_DONEMSG = "Alte Einstellungen f\195\188r |c#RED#%s|r entfernt: %s.",
	CLEANUP_NONEMSG = "Keine der alten Einstellungen bleiben vorhanden.",
	CLEANUP_NOOLDMSG = "Es gibt keine alten Einstellungen f\195\188r den Spieler |c#GREEN#%s|r.",
	CLEANUP_WILLMSG = "Alte Einstellungen bleiben f\195\188r |c#RED#%s|r: %s.",
	CLICKTOSWITCH_INFO = "Falls aktiviert, wird ein Linksklick die Ausr\195\188stungen wechseln, ansonsten wird er das Fishing-Buddy-Fenster \195\182ffnen.",
	CLICKTOSWITCH_ONOFF = "Anklicken, um zu wechseln",
	COMPATIBLE_SWITCHER = "Kein kompatibler Ausr\195\188stungswechsler gefunden.",
	CONFIG_ALWAYSLURE_INFO = "Falls aktiviert, wird ein Angelk\195\182der angebracht, wann immer die Angelrute \195\188ber keinen verf\195\188gt.",
	CONFIG_ALWAYSLURE_ONOFF = "Immer k\195\182dern",
	CONFIG_AUTOLOOT_INFO = "Falls aktiviert, ist das automatische Pl\195\188ndern w\195\164hrend des Angelns eingeschaltet.",
	CONFIG_AUTOLOOT_ONOFF = "Automatisches Pl\195\188ndern",
	CONFIG_AUTOOPEN_INFO = "Falls aktiviert, nutze Doppelklick um Questgegenst\195\164nde zu \195\182ffnen.", -- Needs review
	CONFIG_AUTOOPEN_ONOFF = "Questgegenst\195\164nde \195\182ffnen", -- Needs review
	CONFIG_BGSOUNDS_INFO = "Falls aktiviert, werden die Soundeffekte abgespielt, w\195\164hrend WoW im Hintergrund l\195\164uft.",
	CONFIG_BGSOUNDS_ONOFF = "Soundeffekte im Hintergrund",
	CONFIG_CONTESTS_INFO = "Zeigt einen Timer f\195\188r Angelwettbewerbe an.", -- Needs review
	CONFIG_CONTESTS_ONOFF = "Unterst\195\188tzung f\195\188r Angelwettbewerb", -- Needs review
	CONFIG_DERBYTIMER_INFO = "Falls aktiviert, wird ein Countdown Timer f\195\188r den Beginn des Kalu'ak Angel Derbys angezeigt, sowie ein Countdown f\195\188r die noch verbleibende Zeit.", -- Needs review
	CONFIG_DERBYTIMER_ONOFF = "Derby Timer", -- Needs review
	CONFIG_DRINKHEAVILY_INFO = "Falls aktiviert, trinke ein #LAGER# wenn du angelst und 'trocken' bist.", -- Needs review
	CONFIG_DRINKHEAVILY_ONOFF = "Trinke Lagerbier", -- Needs review
	CONFIG_EASYCAST_INFO = "Auswerfen mittels Doppel-Rechtsklick erm\195\182glichen.",
	CONFIG_EASYCAST_ONOFF = "Einfaches Auswerfen",
	CONFIG_EASYLURES_INFO = "Falls aktiviert, wird ein Angelk\195\182der an der Angel angebracht ehe du beginnst zu angeln - wann immer du einen ben\195\182tigst.",
	CONFIG_EASYLURES_ONOFF = "Einfaches K\195\182dern",
	CONFIG_ENHANCESOUNDS_INFO = "Falls aktiviert, werden die Soundeffekte verst\195\164rkt und die Lautst\195\164rke der Umgebungsger\195\164usche herabgesetzt, so dass der Ton des Angelblinkers w\195\164hrend des Angelns besser wahrnehmbar ist.",
	CONFIG_ENHANCESOUNDS_ONOFF = "Angelger\195\164usche verbessern",
	CONFIG_FINDFISH_INFO = "Die F\195\164higkeit 'Fischsuche' einschalten, wenn Angelausr\195\188stung angelegt ist.",
	CONFIG_FINDFISH_ONOFF = "Fischsuche",
	CONFIG_FISHINGBUDDY_INFO = "Bring out that special buddy while you fish.",
	CONFIG_FISHINGBUDDY_ONOFF = "Fishing Buddy",
	CONFIG_FISHINGFLUFF_INFO = "Enable all sorts of fun while you fish",
	CONFIG_FISHINGFLUFF_ONOFF = "Fishing Fun",
	CONFIG_FISHWATCHONLY_INFO = "Zeige den Fischw\195\164chter nur w\195\164hrend des Angelns an.",
	CONFIG_FISHWATCHONLY_ONOFF = "Nur w\195\164hrend des Angelns",
	CONFIG_FISHWATCHPERCENT_INFO = "Den Prozentanteil jedes Fisches in der Fischw\195\164chteranzeige darstellen.",
	CONFIG_FISHWATCHPERCENT_ONOFF = "Prozentangaben anzeigen",
	CONFIG_FISHWATCHSKILL_INFO = "Die aktuelle Angelfertigkeit und -verbesserungen im Bereich des Fischw\195\164chters anzeigen.",
	CONFIG_FISHWATCHSKILL_ONOFF = "Aktuelle Angelfertigkeit",
	CONFIG_FISHWATCHTIME_INFO = "Anzeigen, wieviel Zeit vergangen ist, seit du zuletzt eine Angelrute angelegt hast.",
	CONFIG_FISHWATCHTIME_ONOFF = "Zeige verstrichene Zeit an",
	CONFIG_FISHWATCHZONE_INFO = "Das aktuelle Gebiet im Bereich des Fischw\195\164chters anzeigen.",
	CONFIG_FISHWATCHZONE_ONOFF = "Aktuelles Gebiet",
	CONFIG_FISHWATCH_INFO = "Anzeige von Text mit dem am aktuellen Standort geangelten Fanggut.",
	CONFIG_FISHWATCH_ONOFF = "Fischw\195\164chter",
	CONFIG_LASTRESORT_INFO = "Falls aktiviert, benutze den gr\195\182\195\159ten vorhandenen K\195\182der, auch wenn er uns nicht auf 100% Fangchance bringt.", -- Needs review
	CONFIG_LASTRESORT_ONOFF = "Gr\195\182\195\159tm\195\182glicher K\195\182der", -- Needs review
	CONFIG_MAXSOUND_INFO = "Falls aktiviert, setze die die Lautst\195\164rke beim Angeln auf Maximum.", -- Needs review
	CONFIG_MAXSOUND_ONOFF = "Volle Lautst\195\164rke", -- Needs review
	CONFIG_MINIMAPBUTTON_INFO = "Symbol von #NAME# an der Minikarte anzeigen.",
	CONFIG_MINIMAPBUTTON_ONOFF = "Symbol an der Minikarte anzeigen",
	CONFIG_MOUNTEDCAST_INFO = "Falls aktiviert, erlaube die Angel auszuwerfen w\195\164hrend man beritten ist.", -- Needs review
	CONFIG_MOUNTEDCAST_ONOFF = "Beritten", -- Needs review
	CONFIG_ONLYMINE_INFO = "Falls aktiviert, wird 'Einfaches Auswerfen' nur die Angelrute der Angelausr\195\188stung heraussuchen (z. B. wird es nicht nach allen m\195\182glichen Angelruten suchen).",
	CONFIG_ONLYMINE_ONOFF = "Nur mit Angel ausr\195\188sten",
	CONFIG_OUTFITTER_TEXT = "Angelfertigkeitsbonus durch Ausr\195\188stung: %s#BR#Draznar's Style-Wertung: %d",
	CONFIG_SHOWLOCATIONZONES_INFO = "Zeige beides, Gebiete und Untergebiete.",
	CONFIG_SHOWLOCATIONZONES_ONOFF = "Gebiete anzeigen",
	CONFIG_SHOWNEWFISHIES_INFO = "Eine Mitteilung im Chat ausgeben, wenn am aktuellen Standort ein neuer Fisch geangelt wurde.",
	CONFIG_SHOWNEWFISHIES_ONOFF = "Neuen Fisch anzeigen",
	CONFIG_SHOWPOOLS_INFO = "If enabled, known pool locations will be displayed on the minimap",
	CONFIG_SHOWPOOLS_ONOFF = "Show pools",
	CONFIG_SORTBYPERCENT_INFO = "Sortiere die Anzeige nach der Anzahl der gefangenen Fische anstatt nach den Namen des Fanggutes.",
	CONFIG_SORTBYPERCENT_ONOFF = "Nach Fanganzahl sortieren",
	CONFIG_SPARKLIES_INFO = "If enabled, the 'sparkles' on fishing pools will be more visible while fishing.",
	CONFIG_SPARKLIES_ONOFF = "Enhance Pools",
	CONFIG_STVPOOLSONLY_INFO = "Falls aktiviert, wird 'Einfaches Auswerfen' nur dann ausgef\195\188hrt, wenn sich der Cursor \195\188ber einem Angelgew\195\164sser befindet.",
	CONFIG_STVPOOLSONLY_ONOFF = "Nur in Schw\195\164rme auswerfen",
	CONFIG_STVTIMER_INFO = "Falls aktiviert, wird f\195\188r den Beginn des Angelwettbewerbs ein Countdown-Timer angezeigt, sowie ein Countdown f\195\188r die noch verbleibende Zeit.",
	CONFIG_STVTIMER_ONOFF = "Timer f\195\188r Angelwettbewerb",
	CONFIG_TOOLTIPS_INFO = "Falls aktiviert, werden die Informationen \195\188ber bereits geangelte Fische im Gegenstands-Tooltip angezeigt.",
	CONFIG_TOOLTIPS_ONOFF = "Angel-Informationen in Tooltips anzeigen",
	CONFIG_TURNOFFPVP_INFO = "Falls aktiviert, wird PvP ausgeschaltet, w\195\164hrend eine Angel angelegt ist.",
	CONFIG_TURNOFFPVP_ONOFF = "PvP ausschalten",
	CONFIG_TURNONSOUND_INFO = "Falls aktiviert, wird beim Angeln immer der Sound eingeschaltet.", -- Needs review
	CONFIG_TURNONSOUND_ONOFF = "Erzwinge Sound", -- Needs review
	CONFIG_USEACTION_INFO = "Falls aktiviert, wird #NAME# nach einer Schaltfl\195\164che in den Aktionsleisten suchen, um diese f\195\188r's Auswerfen zu verwenden.",
	CONFIG_USEACTION_ONOFF = "Aktionstaste verwenden",
	-- CONFIG_WATCHBOBBER_INFO = "If enabled, #NAME# will not cast if the cursor is over the Fishing Bobber",
	CONFIG_WATCHBOBBER_ONOFF = "Watch bobber",
	COPPER_COIN = "Kupferm\195\188nze",
	CURRENT = "aktuell",
	CURRENT_HELP = "|c#GREEN#/fb #CURRENT# #RESET#|r#BR#Zur\195\188cksetzen der w\195\164hrend der gegenw\195\164rtigen Session gefangenen Fische.",
	DERBY = "Derby",
	DESCRIPTION1 = "Fische verfolgen, die du gefangen hast",
	DESCRIPTION2 = "und verwalte deine Angelausr\195\188stung.",
	ELAPSED = "Abgelaufen",
	ELDER_CLEARWATER = "\195\132ltester Reinwasser schreit: (%a)+ hat das Kalu'ak Angel Derby gewonnen!", -- Needs review
	ELEM_WATER = "Elementarwasser",
	EXTRAVAGANZA = "Angelwettbewerb",
	FAILEDINIT = "Nicht korrekt initialisiert.",
	FATLADYSINGS = "|c#RED#%s ist vorbei|r (%d:%02d left)", -- Needs review
	FISH = "Fisch",
	FISHTYPES = "Fischarten: %d",
	FLOATING_DEBRIS = "Treibgut",
	FLOATING_WRECKAGE = "Treibende Wrackteile",
	FORCE = "erzwingen",
	GOLD_COIN = "Goldm\195\188nze",
	HELP = "Hilfe",
	HIDEINWATCHER = "Zeige diesen Fisch im W\195\164chter an.",
	HOURLY = "st\195\188ndlich",
	KEYS_ALT_TEXT = "Alt",
	KEYS_CTRL_TEXT = "Strg",
	KEYS_LABEL_TEXT = "Verbesserungen:",
	KEYS_NONE_TEXT = "Keine",
	KEYS_SHIFT_TEXT = "SHIFT",
	LAGER = "Kapit\195\164n Rumseys Lagerbier",
	LEFTCLICKTODRAG = "Linksklick, um zu bewegen",
	LOCATIONS_INFO = "Zeigt wo du Fische geangelt hast, entweder gem\195\164\195\159 Fanggebieten oder gem\195\164\195\159 Fischart",
	LOCATIONS_TAB = "Standorte",
	MINIMAPBUTTONPLACEMENT = "Platzierung",
	MINIMAPBUTTONPLACEMENTTOOLTIP = "Erm\195\182glicht, das Symbol von #NAME# um die Minikarte herum zu bewegen.",
	MINIMAPBUTTONRADIUS = "Entfernung",
	MINIMAPBUTTONRADIUSTOOLTIP = "Legt die Entfernung des Symbols von #NAME# zu der Minikarte fest.",
	MINIMUMSKILL = "Mindeste Angelfertigkeit: %d",
	NAME = "Fishing Buddy",
	NODATAMSG = "Keine Angeldaten vorhanden.",
	NONEAVAILABLE_MSG = "Keine vorhanden",
	NOREALM = "unbekannter Server",
	NOTLINKABLE = "<Gegenstand ist nicht verkn\195\188pfbar>",
	NOW = "jetzt",
	OFFSET_LABEL_TEXT = "Berechnung:",
	OIL_SPILL = "\195\150lfleck",
	OPTIONS_INFO = "#NAME# Optionen einstellen",
	OPTIONS_TAB = "Optionen",
	OUTFITS = "Ausr\195\188stungen",
	POINT = "Punkt",
	POINTS = "Punkte",
	POST_HELP = "Du kannst die Fensteraktivierung und den#BR#Befehl zum Wechseln deiner Ausstattung in den#BR#\"Tastaturbelegungen\" festlegen.",
	PRE_HELP = "Du kannst |c#GREEN#/fishingbuddy|r oder |c#GREEN#/fb|r f\195\188r alle Befehle benutzen#BR#|c#GREEN#/fb|r: schaltet das Fenster ein/aus.#BR#|c#GREEN#/fb #HELP#|r: zeigt diesen Hilfetext",
	RANDOM = "Random", -- Needs review
	RAW = "unverarbeitet",
	REPLACE = "ersetzen",
	RESET = "zur\195\188cksetzen",
	RIGGLE_BASSBAIT = "^Riggle Barschfang schreit: Wir haben einen Sieger!s+(%a+)s+ist der Meisterangler!",
	RIGHTCLICKFORMENU = "Rechtsklick, um das Men\195\188 zu \195\182ffnen",
	ROLE_ADDON_AUTHORS = "AddOn Autoren", -- Needs review
	ROLE_HELP_BUGS = "Fehlerbeseitigung und Programmierhilfe", -- Needs review
	ROLE_HELP_SUGGESTIONS = "Featurevorschl\195\164ge", -- Needs review
	ROLE_TRANSLATE_DEDE = "Deutsche \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_ESES = "Spanische \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_FRFR = "Franz\195\182sische \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_KOKR = "Koreanische \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_RURU = "Russische \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_ZHCN = "Verinfachte Chinesische \195\156bersetzung", -- Needs review
	ROLE_TRANSLATE_ZHTW = "Traditionelle Chinesische \195\156bersetzung", -- Needs review
	SCHOOL = "Schwarm",
	SHOWFISHIES = "Fische anzeigen",
	SHOWFISHIES_INFO = "Angelverlauf gruppiert nach Fischarten anzeigen.",
	SHOWLOCATIONS = "Standorte",
	SHOWLOCATIONS_INFO = "Angelverlauf gruppiert nach Fanggebieten anzeigen.",
	SILVER_COIN = "Silberm\195\188nze",
	STVZONENAME = "Schlingendorntal",
	SWITCH = "wechseln",
	SWITCH_HELP = "|c#GREEN#/fb #SWITCH#|r#BR#wechsle deine Angelausr\195\188stung und -kleidung.",
	THANKS = "Vielen Dank alle zusammen!", -- Needs review
	TIMELEFT = "%s endet in %d:%02d",
	TIMER = "Zeitmesser",
	TIMERRESET_HELP = "|c#GREEN#/fb #TIMER# #RESET#|r#BR#Reset the location of the Extravaganza timer by moving it to#BR#the middle of the screen.", -- Needs review
	TIMETOGO = "%s beginnt in %d:%02d",
	TOOLTIP_HINT = "Hinweis:",
	TOOLTIP_HINTSWITCH = "Klicken zum Wechseln der Ausr\195\188stungen",
	TOOLTIP_HINTTOGGLE = "Klicken, um das Fenster von #NAME# anzuzeigen.",
	TOOMANYFISHERMEN = "Du hast mehr als eine Mod zum einfachen Auswerfen installiert.",
	TOTAL = "Insgesamt",
	TOTALS = "Insgesamt",
	UPDATE = "aktualisieren",
	UPDATEDB = "DB aktualisieren",
	UPDATEDB_HELP = "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r#BR#Try and find the names of all the fish we don't know already.#BR#An attempt is made to skip 'rare' fish that may disconnect you#BR#from the server -- use the '#FORCE#' option to override the check.", -- Needs review
	UPDATEDB_MSG = "Es wurden %d Fischnamen aktualisiert.",
	WATCHER = "Fischw\195\164chter",
	WATCHER_HELP = "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r oder |c#GREEN##WATCHER_UNLOCK#|r oder |c#GREEN##RESET#|r]#BR#fixieren .. Fixieren der \195\156bersicht,#BR#freigeben .. Entriegeln zum Verschieben,#BR#reset .. Zur\195\188cksetzen", -- Needs review
	WATCHER_LOCK = "fixieren",
	WATCHER_TAB = "W\195\164chter", -- Needs review
	WATCHER_UNLOCK = "Freisetzen",
	WEEKLY = "w\195\182chentlich",
}
