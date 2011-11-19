--[[-------------------------------------------------------
-- TinyTipOptions Localization : Korean
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
-- Contributors: Jspark
--]]

if GetLocale() ~= "koKR" then return end

TinyTipOptionsLocale = setmetatable({
    On = "켜기",
    Off = "끄기",
    GameDefault = "게임 기본 설정",
    TinyTipDefault = "TinyTip의 기본 설정",

    -- TinyTip Positioning
    Opt_Main_Anchor= "위치",
    Opt_MAnchor= "유닛 위치",
    Opt_FAnchor= "프레임 위치",
    Opt_MOffX= "유닛 좌표 [X]",
    Opt_MOffY= "유닛 좌표 [Y]",
    Opt_FOffX= "프레임 좌표 [X]",
    Opt_FOffY= "프레임 좌표 [Y]",

    CURSOR = "커서",

    Desc_Main_Anchor = "툴팁의 위치 설정",
    Desc_MAnchor = "유닛에 마우스를 올렸을 때 나타나는 툴팁의 위치 설정(in the world frame)",
    Desc_FAnchor = "프레임에 마우스를 올렸을때 툴팁의 위치 설정(except the WorldFrame)",
    Desc_MOffX = "유닛 툴팁의 가로 좌표 설정",
    Desc_MOffY = "유닛 툴팁의 세로 좌표 설정",
    Desc_FOffX = "프레임에 마우스를 올렸을 때 툴팁의 가로 좌표 설정",
    Desc_FOffY = "프레임에 마우스를 올렸을 때 툴팁의 세로 좌표 설정",

    -- TinyTipBasic
    Opt_Main_Text= "텍스트",
    Opt_HideRace = "종족 숨김",
    Opt_HideNPCType = "NPC 유형 숨김",
    Opt_KeyElite= "등급 사용",
    Opt_PvPRankText= "PvP 계급",
    Opt_LevelGuess= "레벨 추측",
    Opt_ReactionText= "우호도 텍스트 표시",
    Opt_KeyServer= "서버명 대신 (*) 표시",

    Desc_Main_Text = "유닛 툴팁의 내부에 표시되는 텍스트 변경",
    Desc_HideRace = "플레이어의 경우에 종족의 표시 여부를 선택합니다.",
    Desc_HideNPCType = "NPC 또는 소환수의 유형 표시 여부를 선택합니다.",
    Desc_KeyElite = "++ : 정예, + : 희귀, +++ : 희귀 정예, (!) : 월드 보스",
    Desc_PvPRank = "PvP 계급을 텍스트에 표시 하기위한 옵션 설정",
    Desc_ReactionText = "우호도 텍스트 표시 설정(우호적, 적대정, 등.)",
    Desc_LevelGuess = "알수 없는 레벨 ?? 대신 당신의 레벨 +10으로 표시 설정",
    Desc_KeyServer = "다른 서버의 대상 이름 다음에 (*)를 표시합니다.",

    -- TinyTipBasic / TinyTip
    Opt_Main_Appearance= "형태",
    Opt_Scale= "크기",
    Opt_BGColor= "배경 색상화",
    Opt_Border= "테두리 색상화",
    Opt_ColourFriends= "우호도 특정 색상화",
    Opt_HideInFrames= "유닛 프레임을 위한 툴팁 숨김",
    Opt_HideInCombat = "전투중 툴팁 숨김",

    Map_PvPRankText = {
        [1] = "이름 뒤에 계급 번호 표시",
        [2] = "Off", -- do not change
    },

    Map_BGColor = {
        [1] = "GameDefault", -- do not change
        [2] = "NPC 색상과 같은 색을 사용",
        [3] = "항상 검은색",
    },

    Map_Border = {
        [1] = "GameDefault", -- do not change
        [2] = "테두리 숨김",
    },

    Map_ColourFriends = {
        [1] = "이름 색상만",
        [2] = "색상 사용 않함",
    },

    Desc_Main_Appearance = "툴팁의 형태와 동작 설정",
    Desc_Scale =  "툴팁의 크기 설정",
    Desc_BGColor = "유닛 툴팁의 배경을 위한 색상 설정",
    Desc_Border = "유닛 툴팁의 테두리를 위한 색상 설정",
    Desc_ColourFriends = "친구나 길드원을 위해 각각의 색상 배경 사용",
    Desc_HideInFrames = "유닛 프레임에 마우스를 올렸을 때 툴팁 숨김",
    Desc_HideInCombat = "전투 중일 때 툴팁을 숨깁니다..",

    -- TinyTipTargets
    Opt_Main_Targets= "대상 관련...",
    Opt_TargetsTooltipUnit= "툴팁 유닛의 대상 표시",
    Opt_TargetsParty= "파티",
    Opt_TargetsRaid= "공격대",
    Opt_TargetsNoEventUpdate = "동적 갱신 사용 안함",

    Map_TargetsTooltipUnit = {
        [1] = "새 라인에 유닛의 대상 툴팁 표시",
        [2] = "Off", -- do not change
    },

    Map_TargetsParty = {
        [1] = "각각의 이름 표시",
        [2] = "Off" -- do not change
    },

    Desc_Main_Targets = "유닛 툴팁에 대상의 대상 정보 추가",
    Desc_TargetsTooltipUnit = "툴팁 유닛의 대상의 이름 표시 설정",
    Desc_TargetsParty = "툴팁의 유닛이 파티원을 대상으로 하였다면 표시하기 위한 옵션을 설정",
    Desc_TargetsRaid = "툴팁의 유닛이 공격대원을 대상으로 하였다면 표시하기 위한 옵션을 설정",
    Desc_TargetsNoEventUpdate = "동적 갱신을 사용하지 않으면, 최초로 마우스 오버를 했을 때의 대상 선택자들을 유지함을 의미합니다.",

    Opt_Profiles = "각 케릭터당 설정을 저장",
    Desc_Profiles = "각 케릭터당 혹은 전체 케릭터의 설정을 저장 할지의 여부를 전환.",

    Opt_Main_Default = "설정 초기화",
    Desc_Main_Default = "이 애드온의 설정을 기본으로 되돌림",
    ResetDB_Confirm = "정말로 모든 설정값을 기본값으로 되돌리시겠습니까?",

    Main_General = "일반",
}, {__index=TinyTipOptionsLocale})

