local mod	= DBM:NewMod("Mannoroth", "DBM-Party-Cataclysm", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 6599 $"):sub(12, -3))
mod:SetCreatureID(54969)
mod:SetModelID(38996)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
