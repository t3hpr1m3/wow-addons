--[[-------------------------------------------------------
-- TinyTipOptions Localization : Spanish
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

if GetLocale() ~= "esES" then return end

TinyTipOptionsLocale = setmetatable({
    On = "Activado",
    Off = "Desactivado",
    GameDefault = "Valores por Defecto del Juego",
    TinyTipDefault = "Valores por Defecto de TinyTip",

    -- TinyTip Positioning
    Opt_Main_Anchor = "Anclado",
    Opt_MAnchor = "Ancla de Unidad",
    Opt_FAnchor = "Ancla de Marco",
    Opt_MOffX = "Offset de Unidad [X]",
    Opt_MOffY = "Offset de Unidad [Y]",
    Opt_FOffX = "Offset de Marco [X]",
    Opt_FOffY = "Offset de Marco [Y]",

    Map_Anchor = {
        ["LEFT"] = "IZQUIERDA",
        ["RIGHT"] = "DERECHA",
        ["BOTTOMRIGHT"] = "ABAJO A LA DERECHA",
        ["BOTTOMLEFT"] = "ABAJO A LA IZQUIERDA",
        ["BOTTOM"] = "ABAJO",
        ["TOP"] = "ARRIBA",
        ["TOPLEFT"] = "ARRIBA A LA IZQUIERDA",
        ["TOPRIGHT"] = "ARRIBA A LA DERECHA",
        ["CENTER"] = "CENTRO",
    },

    CURSOR = "CURSOR",
    SMART = "DESGARRADO",

    Desc_Main_Anchor = "Establece la posici\195\179n del tooltip.",
    Desc_MAnchor = "Establece el ancla para el tooltip cuando se pasa el rat\195\179n sobre unidades en el marco del mundo.",
    Desc_FAnchor = "Establece el ancla para el tooltip cuando el rat\195\179n pasa por encima de CUALQUIER marco (excepto el Marco del Mundo).",
    Desc_MOffX = "Establece el offset horizontal desde el punto de anclado para las unidades.",
    Desc_MOffY = "Establece el offset vertical desde el punto de anclado para las unidades.",
    Desc_FOffX = "Establece el offset horizontal desde el punto de anclado cuando se pasa el rat\195\179n por encima de CUALQUIER marco.",
    Desc_FOffY = "Establece el offset vertical desde el punto de anclado cuando se pasa el rat\195\179n por encima de CUALQUIER marco.",

    -- TinyTipBasic
    Opt_Main_Text = "Texto",
    Opt_HideRace = "Ocultar el texto de Raza",
    Opt_HideNPCType = "Ocultar el texto de Tipo de Criatura",
    Opt_KeyElite = "Usar claves de clasificaci\195\179n",
    Opt_PvPRankText = "Rango de JcJ",
    Opt_LevelGuess = "Estimar el nivel",
    Opt_ReactionText = "Mostrar el texto de reacci\195\179nhow Reaction Text",
    Opt_KeyServer = "Mostrar (*) en vez del nombre del servidor",

    Desc_Main_Text = "Cambia qu\195\169 texto se muestra dentro del tooltip de unidad.",
    Desc_HideRace = "Determina si se oculta la raza del jugador.",
    Desc_HideNPCType = "Determina si se oculta el tipo de criatura del jugador.",
    Desc_KeyElite = "Usa + para Raros, ++ para Elites, +++ para Elites Raros, y (!) para Jefes del Mundo.",
    Desc_PvPRankText = "Establece las opciones para mostrar el rango JcJ como texto.",
    Desc_ReactionText = "Determina si se muestra el texto de reacci\195\179n (Aliado, Hostil, etc)",
    Desc_LevelGuess = "Deterrmina si se muestra >(Tu Nivel +10) en vez de ?? para niveles desconocidos.",
    Desc_KeyServer = "Muestra (*) junto al nombre de la unidad en vez de el nombre de servidor si pertenecen a un servidor diferente.",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance = "Apariencia",
    Opt_Scale = "Escala",
    Opt_BGColor = "Coloreado del Fondo",
    Opt_Border = "Coloreado del Borde",
    Opt_ColourFriends = "Colorear a Amigos y compa\195\177eros de Hermandad",
    Opt_HideInFrames = "Ocultar tooltip para marcos de unidad",
    Opt_HideInCombat = "Ocultar tooltip para batallar",

    Map_PvPRankText = {
        [1] = "Mostrar n\195\186mero de rango tras el nombre",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "Colorear PNJs como PJs",
        [3] = "Siempre negro",
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "Ocultar borde",
    },

    Map_ColourFriends = {
        [1] = "Solo colorear nombre",
        [2] = "No colorear"
    },

    Desc_Main_Appearance = "Establece la apariencia y comportamiento del tooltip.",
    Desc_Scale =  "Determina la escala del tooltip (y de los iconos adjuntos).",
    Desc_BGColor = "Establec el esquema de color para el fondo del tooltip de unidad.",
    Desc_Border = "Establece el esquema de color para el borde del tooltip de unidad.",
    Desc_ColourFriends = "Establece el color del fondo o nombre de forma diferente para amigos y compa\195\177eros de hermandad.",
    Desc_HideInFrames = "Oculta el tooltip cuando se pasa el rat\195\179n por encima de marcos de unidad.",
    Desc_HideInCombat = "Oculta el tooltip cuando se pasa el rat\195\179n por encima de batallar.",

    -- TinyTipTargets
    Opt_Main_Targets = "Objetivo de ...",
    Opt_TargetsTooltipUnit = "Unidad del Tooltip",
    Opt_TargetsParty = "Grupo",
    Opt_TargetsRaid = "Banda",

    Map_TargetsTooltipUnit = {
        [1] = "Mostrar el objetivo en la misma linea que el nombre de la unidad",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "Mostrar cada nombre",
        [2] = "Off" -- do not change
    },

    Desc_Main_Targets = "A\195\177ade informaci\195\179n del objetivo del objetivo al tooltip de unidad.",
    Desc_TargetsTooltipUnit = "Determina si se muestra el nombre del objetivo de la unidad del tooltip.",
    Desc_TargetsParty = "Determina si se muestra cu\195\161ntos en tu grupo tienen seleccionada a la unidad del tooltip.",
    Desc_TargetsRaid = "Determina si se muestra cu\195\161ntos en tu banda tienen seleccionada a la unidad del tooltip.",

    Opt_Profiles = "Guardar ajustes por personaje",
    Desc_Profiles = "Determina si se guardan tus ajustes por personaje o globalmente.",

    Opt_Main_Default = "Reestablecer Opciones",
    Desc_Main_Default = "Asigna los valores por defecto a este accesorio.",
}, {__index=TinyTipOptionsLocale})

