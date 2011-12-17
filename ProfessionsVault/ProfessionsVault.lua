local L = PV_locale()
local addonName = L["ProfessionsVault"]
ProfessionsVault = LibStub("AceAddon-3.0"):NewAddon(addonName)
local addon = ProfessionsVault 
local addon_website = "http://www.wowace.com/addons/professionsvault/"
local AceGUI = LibStub("AceGUI-3.0")
local LDB = LibStub("LibDataBroker-1.1")
local minimapIcon = LibStub("LibDBIcon-1.0")
PV_svnrev = {}
PV_svnrev["ProfessionsVault.lua"] = tonumber(("$Revision: 276 $"):match("%d+"))
local DB_VERSION_MAJOR = 1
local DB_VERSION_MINOR = 3

local defaults = {
  profile = {
    debug = false, -- for addon debugging
    autoclose = false, -- close win after using a link
    tooltips = true, -- show tooltips in the ProfessionsVault window
    autoscan = true, -- scan on pattern learn
    locked = false, -- frame lock
    updatemsg = true,
    chattooltips = true,
    recipetooltips = true,
    craftedtooltips = true, 
    ahcolor = true,
    merchantcolor = true,
    bagcolor = true,
    bankcolor = true,
    mailcolor = true,
    colorttnames = false,
    colorwinnames = true,
    selfdata = true,
    altdata = true,
    otherdata = false,
    factiondata = false,
    grpbyprof = false,
    pos = {
      height = 432,
      width  = 510,
      left   = GetScreenWidth()/2-250,
      top    = GetScreenHeight()/2+200,
    },
    treestatus = {
      treewidth = 230,
    },
    minimap = {
      hide = false,
    },
    charcolor = {
      self =   { 0x0, 0xff, 0x0  },
      alt =    { 0x0, 0xff, 0x33 },
      other =  { 0x0, 0xcc, 0xcc },
      falt =   { 0xff, 0x0, 0x0 },
      fother = { 0xff, 0x33, 0x33 },
      system = { 0xff, 0xff, 0x0 },
    },
    recipecolor = {
      learn_self  = { 1.0, 1.0, 1.0 },
      learn_alt   = { 0.3, 1.0, 0.3 },
      learn_other = { 0.3, 1.0, 0.3 },
      learn_faction = { 0.3, 1.0, 0.3 },
      skill_self  = { 1.0, 1.0, 0.1 },
      skill_alt   = { 1.0, 1.0, 0.1 },
      skill_other = { 1.0, 1.0, 0.1 },
      skill_faction = { 1.0, 1.0, 0.1 },
      known_self  = { 0.3, 0.3, 1.0 },
      known_alt   = { 0.3, 0.3, 1.0 },
      known_other = { 0.3, 0.3, 1.0 },
      known_faction = { 0.3, 0.3, 1.0 },
      unknown     = { 1.0, 0.1, 0.1 },
      dunno       = { 1.0, 0.1, 0.1 },
    },
  }
}

local GetTradeSkillListLink = GetTradeSkillListLink

local headerfont = GameFontHighlightLarge
local bodyfont = GameFontHighlightLarge
local activateontree = true
local useMerchantTimer = false
local enhanceColorPicker = true
local ttwrapwidth = 50 -- tooltip wrap width, 0 for auto
local gamerankmax = 525
local maxcachesz = 200
local usehashes = true
local einstein = L["All Recipes"]
local allexpand = "All Expand"
local allexpandplus = "Interface\\Buttons\\UI-PlusButton-UP"
local allexpandminus = "Interface\\Buttons\\UI-MinusButton-UP"
local locale = GetLocale()
if locale == "enGB" then locale = "enUS" end
local rcolortable

BINDING_NAME_PROFESSIONSVAULT = L["Show/Hide the ProfessionsVault window"]
BINDING_HEADER_PROFESSIONSVAULT = "ProfessionsVault"

local _ve = GetExpansionLevel()
local _vv,_vb,_,_vtoc = GetBuildInfo()
local _vwarned = false
_vb = tonumber(_vb)
local function vs(wotlkv40,catav40,catav406,catav420,catav430)
  local warn = false
  if wotlkv40 == 0 or wotlkv40 == 1 then return wotlkv40 end
  local res
  if (_vtoc >= 40300) or _vv == "4.3.0" then -- second clause for PTR
    res = catav430 
  elseif (_vtoc >= 40200) then
    res = catav420 
  elseif (_vb < 13205) then 
    res = wotlkv40
    warn = true 
  elseif (_vb >= 13205 and _vb < 13287) then 
    res = wotlkv40
  elseif (_vb >= 13287 and _vb <= 13329) then
    res = catav40
  elseif (_vb > 13329) then
    res = catav406
  else
    res = catav40
    warn = true 
  end
  if warn and not _vwarned then
      print(format(L["ERROR: unrecognized client version %s, Please download an update from %s."],
                    format("%s-%d",_vv, _vb), addon_website))
      _vwarned = true
  end
  return res
end

local PID_ALCH = 2259
local PID_BS   = 2018
local PID_ENCH = 7411
local PID_ENG  = 4036
local PID_HERB = 9134
local PID_SKIN = 8613
local PID_INSC = 45357
local PID_JC   = 25229
local PID_LW   = 2108
local PID_MINE = 2575
local PID_SMELT= 2656
local PID_TAIL = 3908
local PID_ARCH = 78670
local PID_COOK = 2550
local PID_FA   = 3273
local PID_FISH = 7620

local primaryProf = {  -- 0 == no tradeskill, 1 == broken
        [PID_ALCH] = {vs(44,52,52,52,53), -- Alchemy
	            28677, -- Elixer Master 
		    28675, -- Potion Master
		    28672, -- Transmutation Master
		 },
	[PID_BS] = {vs(87,99,99,101,102), -- Blacksmithing
	            9787, -- Weaponsmith
		    9788, -- Armorsmith
	         },
	[PID_ENCH] =  vs(51,60,61,61,61), -- Enchanting
	[PID_ENG] = {vs(51,57,57,58,57), -- Engineering
	            20219, -- Gnomish Engineer
		    20222, -- Goblin Engineer
	         },
	[PID_INSC] = vs(73,79,80,80,80), -- Inscription 
	[PID_JC] = vs(84,100,101,102,113), -- Jewelcrafting 
	[PID_LW] = {vs(89,102,102,105,106), -- Leatherworking
                    10656, -- Dragonscale Leatherworking
                    10660, -- Tribal Leatherworking
                    10658, -- Elemental Leatherworking
	         },
	[PID_TAIL] = {vs(73,83,83,84,85), -- Tailoring
	            26797, -- Spellfire Tailoring
		    26798, -- Mooncloth Tailoring
		    26801, -- Shadoweave Tailoring
		 },
	[PID_SKIN] =  vs(0), -- Skinning
	[PID_HERB] =  vs(0), -- Herbalism
	[PID_MINE] =  vs(0), -- Mining
	[PID_SMELT] =  vs(1), -- Smelting
}
local secondaryProf = { 
	[PID_ARCH] = vs(0), -- Archaeology
	[PID_COOK] =  vs(31,36,36,36,36), -- Cooking
	[PID_FA] =  vs(6, 7, 7,7,7), -- First Aid 
	[PID_FISH] =  vs(0), -- Fishing
}

local nolinkProf = {  -- professions that dont have a trade: link
	[GetSpellInfo(PID_MINE)] = true,  
	[GetSpellInfo(PID_SMELT)] = true,
	[GetSpellInfo(PID_FISH)] = true, 
	[GetSpellInfo(PID_ARCH)] = true, 
	[GetSpellInfo(PID_HERB)] = true, 
	[GetSpellInfo(PID_SKIN)] = true, 
	[GetSpellInfo(53428)] = true, -- Runeforging
}
local nocastProf = { -- professions that can't be safely cast
	[GetSpellInfo(PID_MINE)] = true,  
	[GetSpellInfo(PID_FISH)] = true, 
	[GetSpellInfo(PID_HERB)] = true, 
	[GetSpellInfo(PID_SKIN)] = true, 
}
local function translateIDs(t) 
  local r = {}
  for k,v in pairs(t) do
    local name, _, icon = GetSpellInfo(k)
    if not name then
      debug("Failed to find spellID "..k)
    else
      r[name] = {}
      r[name].icon = icon
      r[name].spellid = k
      local aliases = {}
      if type(v) == "table" then
        r[name].patlen = v[1]
	table.remove(v,1)
	for _,a in ipairs(v) do
	  local an = GetSpellInfo(a)
	  table.insert(aliases, an)
	end
      else
        r[name].patlen = v
      end
      r[name].aliases = aliases
    end
  end
  return r
end
primaryProf = translateIDs(primaryProf)
secondaryProf = translateIDs(secondaryProf)
local allProf = {}
local allProfSorted = {}
do 
  for p,v in pairs(primaryProf) do allProf[p]=v ; table.insert(allProfSorted, p) end
  table.sort(allProfSorted)
  local tmp = {}
  for p,v in pairs(secondaryProf) do allProf[p]=v ; table.insert(tmp, p)end
  table.sort(tmp)
  for _,v in ipairs(tmp) do table.insert(allProfSorted, v) end
  --myprint(allProfSorted)
end

local LFaction = {
  Alliance = FACTION_ALLIANCE,
  Horde = FACTION_HORDE
}

local DB, DBc, settings
local charName
local optionsFrame, colorFrame, unhideFrame

local function chatMsg(msg)
     DEFAULT_CHAT_FRAME:AddMessage("\124cFF00FF00"..addonName.."\124r: "..msg)
end
addon.chatMsg = chatMsg
local function debug(msg)
  if settings and settings.debug then
     DEFAULT_CHAT_FRAME:AddMessage("\124cFFFF0000"..addonName.."\124r: "..msg)
  end
end
function addon:usingColor() 
  return settings.recipetooltips or settings.craftedtooltips or
         settings.ahcolor or settings.merchantcolor or settings.bagcolor or
         settings.bankcolor or settings.mailcolor
end

local function table_clone(t)
  if not t then return nil end
  local r = {}
  for k,v in pairs(t) do
    local nk,nv = k,v
    if type(k) == "table" then
      nk = table_clone(k)
    end
    if type(v) == "table" then
      nv = table_clone(v)
    end
    r[nk] = nv
  end
  return r
end

local function myOptions() 
return {
  type = "group",
  args = {
   general = {
    type = "group",
    inline = true,
    name = L["General"],
    args = {
    debug = {
      name = L["Debug"],
      desc = L["Toggle debugging output"],
      type = "toggle",
      guiHidden = true,
      set = function(info,val) settings.debug = val ; 
                               chatMsg("Debug output "..((val and "enabled") or "disabled")) end,
      get = function(info) return settings.debug end
    },
    reset = {
      name = L["Reset"],
      desc = L["Reset the database"],
      type = "execute",
      order = 120,
      func = function() addon:Reset(); end,
    },
    dump = {
      name = L["Dump"],
      desc = L["Dump the database to chat window"],
      type = "execute",
      guiHidden = true,
      func = function() addon:Dump()  end,
    },
    save = {
      name = L["Save"],
      desc = L["Save this trade skill to ProfessionsVault"],
      type = "execute",
      guiHidden = true,
      func = function() addon:UpdateTrade(true) end,
    },
    scan = {
      name = L["Scan My Professions"],
      desc = L["Scan My Professions"],
      type = "execute",
      guiHidden = true,
      func = function() addon:ScanProfessions()  end,
    },
    oheader = {
      name = L["General Options"],
      type = "header",
      cmdHidden = true,
      order = 0,
    },
    ttheader = {
      name = L["Actions"],
      type = "header",
      cmdHidden = true,
      order = 100,
    },
    aheader = {
      name = L["Recipe Options"],
      type = "header",
      cmdHidden = true,
      order = 44,
    },
    show = {
      name = L["Show"],
      desc = L["Show/Hide the ProfessionsVault window"],
      type = "execute",
      order = 110,
      func = function() addon:ToggleWindow()  end,
    },
    kheader = {
      name = L["Keybinding"],
      type = "header",
      cmdHidden = true,
      order = 200,
    },
    togglebind = {
      desc = L["Bind a key to toggle the ProfessionsVault window"],
      type = "keybinding",
      name = L["Show/Hide the ProfessionsVault window"],
      cmdHidden = true,
      order = 210,
      width = double,
      set = function(info,val) 
         local b1, b2 = GetBindingKey("PROFESSIONSVAULT")
         if b1 then SetBinding(b1) end
         if b2 then SetBinding(b2) end
         SetBinding(val, "PROFESSIONSVAULT") 
	 SaveBindings(GetCurrentBindingSet())
      end,
      get = function(info) return GetBindingKey("PROFESSIONSVAULT") end
    },
    config = {
      name = L["Config"],
      desc = L["Show the ProfessionsVault configuration window"],
      type = "execute",
      guiHidden = true,
      func = function() addon:Config()  end,
    },
    autoclose = {
      name = L["Autoclose"],
      desc = L["Automatically close the ProfessionsVault window when opening a profession"],
      type = "toggle",
      order = 10,
      set = function(info,val) settings.autoclose = val end,
      get = function(info) return settings.autoclose end
    },
    tooltips = {
      name = L["Tooltips"],
      desc = L["Show tooltips in the ProfessionsVault window"],
      type = "toggle",
      order = 30,
      set = function(info,val) settings.tooltips = val end,
      get = function(info) return settings.tooltips end
    },
    chattooltips = {
      name = L["Chat Tooltips"],
      desc = L["Show tooltips for trade links in the chat window"],
      type = "toggle",
      order = 40,
      set = function(info,val) settings.chattooltips = val end,
      get = function(info) return settings.chattooltips end
    },
    updatemsg = {
      name = L["Update Messages"],
      desc = L["Print messages to the chat window to show database updates"],
      type = "toggle",
      order = 41,
      set = function(info,val) settings.updatemsg = val end,
      get = function(info) return settings.updatemsg end
    },
    --[[
    autoscan = {
      name = L["Scan on recipe learn"],
      desc = L["Prompt to perform an update scan when a new recipe is learned"],
      type = "toggle",
      order = 35,
      set = function(info,val) settings.autoscan = val end,
      get = function(info) return settings.autoscan end
    },--]]
    recipetooltips = {
      name = L["Recipe Tooltips"],
      desc = L["Enhance recipe tooltips with ProfessionsVault character data"],
      type = "toggle",
      order = 45,
      set = function(info,val) settings.recipetooltips = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.recipetooltips end
    },
    craftedtooltips = {
      name = L["Crafted Item Tooltips"],
      desc = L["Enhance crafted item tooltips with ProfessionsVault character data"],
      type = "toggle",
      order = 46,
      set = function(info,val) settings.craftedtooltips = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.craftedtooltips end
    },
    ahcolor = {
      name = L["AH coloring"],
      desc = L["Color recipes in the AH window with ProfessionsVault character data"],
      type = "toggle",
      order = 47,
      set = function(info,val) settings.ahcolor = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.ahcolor end
    },
    merchantcolor = {
      name = L["Merchant coloring"],
      desc = L["Color recipes in the merchant window with ProfessionsVault character data"],
      type = "toggle",
      order = 48,
      set = function(info,val) settings.merchantcolor = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.merchantcolor end
    },
    bagcolor = {
      name = L["Bag coloring"],
      desc = L["Color recipes in player bags with ProfessionsVault character data"],
      type = "toggle",
      order = 49,
      set = function(info,val) settings.bagcolor = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.bagcolor end
    },
    bankcolor = {
      name = L["Bank coloring"],
      desc = L["Color recipes in bank and guild bank with ProfessionsVault character data"],
      type = "toggle",
      order = 49,
      set = function(info,val) settings.bankcolor = val ; 
                addon:RefreshTooltips()
                if GuildBankFrame_Update then GuildBankFrame_Update(true) end
            end,
      get = function(info) return settings.bankcolor end
    },
    mailcolor = {
      name = L["Mail coloring"],
      desc = L["Color recipes in mailbox with ProfessionsVault character data"],
      type = "toggle",
      order = 49,
      set = function(info,val) settings.mailcolor = val ; addon:RefreshTooltips(); InboxFrame_Update(true) end,
      get = function(info) return settings.mailcolor end
    },
    dheader = {
      name = L["Recipe Data Options"],
      type = "header",
      cmdHidden = true,
      order = 50,
    },
    recipeself = {
      name = L["Include self"],
      desc = L["Include profession data from self"],
      type = "toggle",
      order = 51,
      disabled = function() return not addon:usingColor() end,
      set = function(info,val) settings.selfdata = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.selfdata end
    },
    recipealts = {
      name = L["Include alts"],
      desc = L["Include profession data from alts"],
      type = "toggle",
      order = 52,
      disabled = function() return not addon:usingColor() end,
      set = function(info,val) settings.altdata = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.altdata end
    },
    recipeothers = {
      name = L["Include others"],
      desc = L["Include profession data from non-alts"],
      type = "toggle",
      order = 53,
      disabled = function() return not addon:usingColor() end,
      set = function(info,val) settings.otherdata = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.otherdata end
    },
    recipefaction = {
      name = L["Include opposite faction"],
      desc = L["Include profession data from opposite faction"],
      type = "toggle",
      order = 54,
      disabled = function() return not addon:usingColor() end,
      set = function(info,val) settings.factiondata = val ; addon:RefreshTooltips() end,
      get = function(info) return settings.factiondata end
    },
    minimap = {
      name = L["Minimap icon"],
      desc = L["Show minimap icon"],
      type = "toggle",
      order = 30,
      get = function(info) return not settings.minimap.hide end,
      set = function(info,val) 
                  settings.minimap.hide = not val
		  if settings.minimap.hide then
		    minimapIcon:Hide(addonName)
		  else
		    minimapIcon:Show(addonName)
		  end
            end
    },
   }}, -- general
  unhide = {
   type = "group",
   name = L["Unhide Entries"],
   args = {
     desc = {
       order = 10,
       type = "description",
       fontSize = "medium",
       cmdHidden = true, 
       dropdownHidden = true,
       name = L["unhide_desc"]
     },
     unhidesel = {
       order = 20,
       name = L["Unhide Selected"],
       type = "execute",
       cmdHidden = true, 
       dropdownHidden = true,
       disabled = function() for _,v in pairs(PV_unhide or {}) do if v then return false end end; return true end,
       func = function() 
         --myprint(PV_unhide)
	 for k,v in pairs(PV_unhide) do
	   if v then
	     addon.db.realm.hide[k] = nil
	   end
	   PV_unhide[k] = nil
	 end
         addon:RefreshTooltips(); addon:RefreshWindow();
       end,
     },
     all = {
       order = 30,
       name = L["Unhide All"],
       type = "execute",
       func = function () addon.db.realm.hide = {}; addon:RefreshTooltips(); addon:RefreshWindow(); end
     },
     hidelist = {
       order = 40,
       name = L["Currently Hidden Entries"]..":",
       type = "multiselect",
       cmdHidden = true, 
       dropdownHidden = true,
       values = function() local t = {}; PV_unhide = PV_unhide or {} ; for k,_ in pairs(addon.db.realm.hide) do t[k] = k end return t end,
       get = function(info,key) return PV_unhide[key] end,
       set = function(info,key,val) PV_unhide[key] = val end,
     },
  }}, -- unhide
  color = {
   type = "group",
   name = L["Color"],
   args = {
    ttnames = {
      name = L["Tooltip names"],
      desc = L["Color character names in tooltips"],
      type = "toggle",
      order = 20,
      set = function(info,val) settings.colorttnames = val; addon:RefreshTooltips() end,
      get = function(info) return settings.colorttnames end
    },
    winnames = {
      name = L["Window names"],
      desc = L["Color character names in window"],
      type = "toggle",
      order = 10,
      set = function(info,val) settings.colorwinnames = val; addon:RefreshWindow() end,
      get = function(info) return settings.colorwinnames end
    },
    charactercolor = {
      name = L["Character colors"],
      type = "group",
      inline = true,
      order = 100,
      get = function (info) 
              settings.charcolor = settings.charcolor or table_clone(defaults.profile.charcolor)
	      local r,g,b,a = unpack(settings.charcolor[info[#info]])
              return r/255.0, g/255.0, b/255.0, (a or 255)/255.0
	    end,
      set = function (info,r,g,b,a) 
              local chartype = info[#info]
	      --debug("Setting color for chartype: "..chartype)
              settings.charcolor = settings.charcolor or table_clone(defaults.profile.charcolor)
              settings.charcolor[chartype] = {r*255,g*255,b*255,a*255} 
              addon:updateColors()
	    end,
      args = {
        self =   { type = "color", order = 10, name = L["Self"] },
        system = { type = "color", order = 15, name = L["System"] },
        alt =    { type = "color", order = 20, name = L["Alts"] },
        other =  { type = "color", order = 30, name = L["Others"] },
        falt =   { type = "color", order = 40, name = L["Cross-faction"].." "..L["Alts"] },
        fother = { type = "color", order = 50, name = L["Cross-faction"].." "..L["Others"] },
      }
    },
    recipecolor = {
      name = L["Recipe colors"],
      type = "group",
      inline = true,
      order = 200,
      get = function (info)
              settings.recipecolor = settings.recipecolor or table_clone(defaults.profile.recipecolor)
              local r,g,b,a = unpack(settings.recipecolor[info[#info]])
              return r, g, b, (a or 1.0)
            end,
      set = function (info,r,g,b,a)
              local rtype = info[#info]
              --debug("Setting color for recipetype: "..rtype)
              settings.recipecolor = settings.recipecolor or table_clone(defaults.profile.recipecolor)
              settings.recipecolor[rtype] = {r,g,b,a}
              addon:RefreshTooltips()
            end,
      args = {
	learn_self    = { type = "color", order = 10, name = L["Learnable"].." "..L["Self"] },
	learn_alt     = { type = "color", order = 20, name = L["Learnable"].." "..L["Alts"] },
	learn_other   = { type = "color", order = 30, name = L["Learnable"].." "..L["Others"] },
	learn_faction = { type = "color", order = 40, name = L["Learnable"].." "..L["Cross-faction"] },
	skill_self    = { type = "color", order = 50, name = L["Skill too low"].." "..L["Self"] },
	skill_alt     = { type = "color", order = 60, name = L["Skill too low"].." "..L["Alts"] },
	skill_other   = { type = "color", order = 70, name = L["Skill too low"].." "..L["Others"] },
	skill_faction = { type = "color", order = 80, name = L["Skill too low"].." "..L["Cross-faction"] },
	known_self    = { type = "color", order = 100, name = L["Known"].." "..L["Self"] },
	known_alt     = { type = "color", order = 110, name = L["Known"].." "..L["Alts"] },
	known_other   = { type = "color", order = 120, name = L["Known"].." "..L["Others"] },
	known_faction = { type = "color", order = 130, name = L["Known"].." "..L["Cross-faction"] },
	unknown       = { type = "color", order = 200, name = L["Not Known"] },
	dunno         = { type = "color", order = 210, name = L["Not sure"] },
      }
    },
  }} -- colors
  }
} 
end

if enhanceColorPicker then
-- WTB HookScript on a texture >.<
-- ColorPickerFrame:HookScript("OnColorSelect") would be more elegant, 
-- but no way to unambiguously retrieve the rgb info
local csst = ColorSwatch.SetTexture
ColorSwatch.SetTexture = function(self,r,g,b,a)
  --myprint(r,g,b,a) 
  local pc = InterfaceOptionsFramePanelContainer
  if not pc then return end
  if r and g and b and pc:IsVisible() and pc.displayedPanel == colorFrame then
    csst(self,"Interface\\Icons\\inv_scroll_03")
    self:SetVertexColor(r,g,b, (a or 1))
  else
    self:SetVertexColor(1,1,1,1)
    csst(self, r,g,b,a) 
  end
end
end

local function charcolor(chartype)
  local r,g,b,a = unpack(settings.charcolor[chartype])
  local str = string.format("%02x%02x%02x",r,g,b)
  --print(str)
  return str
end

local function coloredcname(cname,usecolor)
  local color, ctype
  local dbc = DB.chars[cname]
  if cname == einstein then
    color = charcolor("system")
    ctype = "system"
  elseif cname == charName then
    color = charcolor("self")
    ctype = "self"
  elseif dbc.data and dbc.data.faction ~= DBc.data.faction and dbc.data.alt then
    color = charcolor("falt")
    ctype = "faction"
  elseif dbc.data and dbc.data.faction ~= DBc.data.faction then
    color = charcolor("fother")
    ctype = "faction"
  elseif dbc.data and dbc.data.alt then
    color = charcolor("alt")
    ctype = "alt"
  else 
    color = charcolor("other")
    ctype = "other"
  end
  if usecolor then
    return "\124cff"..color..cname.."\124r", ctype
  else
    return cname, ctype
  end
end

local function charicon(cname)
    local dbc = DB.chars[cname]
    if cname == einstein then
      return "Interface\\Icons\\inv_misc_book_07"
    elseif dbc and dbc.data and dbc.data.faction and dbc.data.faction == "Horde" then
      return "Interface\\BattlefieldFrame\\Battleground-Horde"
      --return "Interface\\TargetingFrame\\UI-PVP-Horde"
    elseif dbc and dbc.data and dbc.data.faction and dbc.data.faction == "Alliance" then
      return "Interface\\BattlefieldFrame\\Battleground-Alliance"
      --return "Interface\\TargetingFrame\\UI-PVP-Alliance"
    else 
      return "Interface\\GossipFrame\\ActiveQuestIcon"
    end
end

local function chardatastr(cname)
  local data = DB.chars[cname] and DB.chars[cname].data
  if not data then
    return nil
  end
  local text = ""
  for _,stat in ipairs({"level","faction","class"}) do
    local val = data[stat]
    if stat == faction and val then val = LFaction[val] end
    if val then
       text = text..val.." "
    end
  end
  if data.alt then
    text = text.." ("..L["alt"]..")"
  end
  return text
end

function addon:isHidden(cname,pname)
  cname = cname or "*"
  pname = pname or "*"
  return DB.hide[cname.."/"..pname] or 
         DB.hide["*/"..pname] or 
         DB.hide[cname.."/*"] 
end

function addon:RefreshChar()
  debug("RefreshChar")
  DB.chars[charName] = DB.chars[charName] or {}
  DBc = DB.chars[charName]
  DBc.data = DBc.data or {}
  DBc.data.name = charName
  DBc.data.faction = UnitFactionGroup("player")
  DBc.data.level = UnitLevel("player")
  DBc.data.class = UnitClass("player")
  DBc.data.scanned = DBc.data.scanned or false
  if DBc.data.alt == nil then
    DBc.data.alt = true
  end
end

function addon:RefreshConfig()
  debug("RefreshConfig")
  charName = UnitName("player")
  DB = self.db.realm
  DB.chars = DB.chars or {}
  DB.hide = DB.hide or {}
  DB.guid_cache = DB.guid_cache or {}

  settings = addon.db.profile
  addon.settings = settings
  settings.vermaj = settings.vermaj or DB_VERSION_MAJOR
  settings.vermin = settings.vermin or DB_VERSION_MINOR

  if settings.debug then
    PV = addon
  end

  -- ticket 13: this seems to help, dont ask me why. Fuck AceGUI.
  if settings.treestatus then
    settings.treestatus.scrollvalue = 0
  end

  addon:RefreshChar()
  addon:RefreshWindow()
end

local function resetSettings() 
  debug("resetSettings")
  local ishown = InterfaceOptionsFrame:IsShown()
  local wshown = addon.gui and true
  if wshown then
    addon:ToggleWindow()
  end
  if ishown then
    InterfaceOptionsFrame:Hide();
  end

  addon.db.profile = table_clone(defaults.profile)

  addon:RefreshConfig()
  addon:AddEinstein()
  if ishown then
    InterfaceOptionsFrame_OpenToCategory(optionsFrame)
  end
  if wshown then
    addon:ToggleWindow()
  end
end

function addon:updateColors()
  addon:RefreshWindow()
  addon:RefreshTooltips()
end

function addon:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("ProfessionsVaultDB", defaults)
  local options = myOptions()
  rcolortable = options.args.color.args.recipecolor.args
  LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {L["professionsvault"], L["pv"]})
  optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonName, nil, "general")
  optionsFrame.default = resetSettings
  colorFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, L["Color"], addonName,"color")
  colorFrame.default = function () 
     settings.charcolor = table_clone(defaults.profile.charcolor)
     settings.recipecolor = table_clone(defaults.profile.recipecolor)
     if InterfaceOptionsFrame:IsShown() then
       InterfaceOptionsFrame:Hide();
       InterfaceOptionsFrame_OpenToCategory(colorFrame)
     end
     addon:updateColors() end
  unhideFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, L["Unhide Entries"], addonName,"unhide")
  options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
  LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, L["Profiles"], addonName, "profiles")
  LibStub("AceEvent-3.0"):Embed(addon)
  if useMerchantTimer then LibStub("AceTimer-3.0"):Embed(addon) end
  settings = addon.db.profile

  debug("OnInitialize")

  addon:build_tables()

  self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
  self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
  self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
  self.db.RegisterCallback(self, "OnDatabaseReset", "RefreshConfig")
  self:RefreshConfig()
end

function addon:SetupVersion()
   local svnrev = 0
   PV_svnrev["X-Build"] = tonumber((GetAddOnMetadata("ProfessionsVault", "X-Build") or ""):match("%d+"))
   PV_svnrev["X-Revision"] = tonumber((GetAddOnMetadata("ProfessionsVault", "X-Revision") or ""):match("%d+"))
   for _,v in pairs(PV_svnrev) do -- determine highest file revision
     if v and v > svnrev then
       svnrev = v
     end
   end
   ProfessionsVault.revision = svnrev

   PV_svnrev["X-Curse-Packaged-Version"] = GetAddOnMetadata("ProfessionsVault", "X-Curse-Packaged-Version")
   PV_svnrev["Version"] = GetAddOnMetadata("ProfessionsVault", "Version")
   ProfessionsVault.version = PV_svnrev["X-Curse-Packaged-Version"] or PV_svnrev["Version"] or "@"
   if string.find(ProfessionsVault.version, "@") then -- dev copy uses "@.project-version.@"
      ProfessionsVault.version = "r"..svnrev
   end
end
local function PV_ShowTooltip(self,...)
        if addon.settings.recipetooltips or addon.settings.craftedtooltips or 
	   ((addon.settings.ahcolor or addon.settings.merchantcolor) and self == addon.scantt) then
                addon:ShowTooltip(self)
        end
end
local function PV_ShowItemRefTooltip(cleanlink, link, button, frame)
	if not link and cleanlink then -- ticket 50
	  link = addon:dirtylink(cleanlink)
          debug("PV_ShowItemRefTooltip: link="..link.." cleanlink="..cleanlink)
	end
	if not link then
	  return
	end
        if (addon.settings.recipetooltips or addon.settings.craftedtooltips) and
	   (string.find(link,"\124Hitem:",1,true) or string.find(link,"\124Henchant:",1,true)) then
                addon:ShowTooltip(ItemRefTooltip)
        end
	if string.find(link, "\124Htrade:",1,true) then -- opened a tradeskill UI link
	   addon.lastTSL = link
	   addon:update_guid_cache_fromlink(link)
	   debug("Set addon.lastTSL = "..(addon.lastTSL or "nil").." ("..addon:hash(addon.lastTSL)..")")
	   addon:UpdateTrade(false) 
	end
end
local function PV_AuctionScroll(...)
        if addon.settings.ahcolor then
	        addon:SetAuctionColors()
        end
end

local function SetLDBProf(pname)
  if not pname then pname = settings.ldbprof end
  local pnamecast = pname
  if pname == GetSpellInfo(PID_SMELT) then
     pname = GetSpellInfo(PID_MINE)
  end
  if pname and PVLDB and DBc[pname] then
    local pinfo = DBc[pname]
    local rank = pinfo.rank or "??"
    local rankmax = pinfo.rankmax or "??"
    local tex = "|T"..allProf[pname].icon..":0|t"
    PVLDB.text = " "..tex.." ("..rank.."/"..rankmax..")"
    settings.ldbprof = pnamecast
  else
    settings.ldbprof = nil
    PVLDB.text = addonName
  end
end

local function PV_CastSpellHook(...)
        if InCombatLockdown() then return end
	local pname = GetSpellInfo(...)
	if (allProf[pname]) then
	  debug("CastSpell("..pname..")")
	  addon.lastTSL = nil
	  SetLDBProf(pname)
	end
end

local function PV_UseActionHook(actionslot, target, button)
        if InCombatLockdown() then return end
	local atype, id, subType = GetActionInfo(actionslot)
	if (atype == "spell" and subType == "spell") then
	  local pname = GetSpellInfo(id)
	  if (allProf[pname]) then
	    debug("UseAction("..pname..")")
	    addon.lastTSL = nil
	    SetLDBProf(pname)
	  end
	end
end

function addon:ADDON_LOADED()
        if IsAddOnLoaded("Blizzard_AuctionUI") and not addon.auchook then
          hooksecurefunc("AuctionFrameBrowse_Update", PV_AuctionScroll)
	  addon.auchook = true
        end
        if IsAddOnLoaded("Auc-Advanced") and not addon.AuctioneerAdv then
                if AucAdvanced.Settings.GetSetting("util.compactui.activated") then
                        debug("Auctioneer Advanced CompactUI detected")
                        addon.AuctioneerAdv = true
                end
        end
        if GuildBankFrame_Update and not addon.gbhooked then
          hooksecurefunc("GuildBankFrame_Update", function(...) addon:GuildBankFrame_Update(...) end)
          addon.gbhooked = true
        end
        if Bagnon and Bagnon.ItemSlot and Bagnon.ItemSlot.UpdateSlotColor and not addon.bagnonhooked then
          hooksecurefunc(Bagnon.ItemSlot, "UpdateSlotColor", addon.bagnon_hook)
	  addon.bagnonhooked = true
        end
        if ArkInventory and not addon.arkinvhooked then
          if ArkInventory.SetItemButtonTexture then
            hooksecurefunc(ArkInventory, "SetItemButtonTexture", addon.arkinv_hook)
          end
          if ArkInventory.SetItemButtonDesaturate then
            hooksecurefunc(ArkInventory, "SetItemButtonDesaturate", addon.arkinv_hook)
          end
	  addon.arkinvhooked = true
        end
        if Baggins and Baggins.UpdateItemButton and not addon.bagginshooked then
          hooksecurefunc(Baggins, "UpdateItemButton", addon.baggins_hook)
	  addon.bagginshooked = true
        end
	if IsAddOnLoaded("OneBag3") then
	  addon.onebagaddon = true
	end
	if IsAddOnLoaded("Combuctor") and not addon.combuctorhooked then
	  local Combuctor = LibStub('AceAddon-3.0'):GetAddon('Combuctor',true)
	  if Combuctor and Combuctor.ItemSlot then
            hooksecurefunc(Combuctor.ItemSlot, "UpdateSlotColor", addon.combuctor_hook)
	    addon.combuctorhooked = true
	  end
	end
end

function addon:OnEnable()
  debug("OnEnable")

  self:SetupVersion()

  addon:AddEinstein()
  addon:CleanDatabase()

  self:RegisterEvent("TRADE_SKILL_SHOW")
  self:RegisterEvent("TRADE_SKILL_NAME_UPDATE")
  self:RegisterEvent("ADDON_LOADED")
  self:RegisterEvent("MERCHANT_UPDATE")
  self:RegisterEvent("MERCHANT_SHOW")
  self:RegisterEvent("MERCHANT_CLOSED")
  self:RegisterEvent("CHAT_MSG_SYSTEM")
  self:RegisterEvent("CHAT_MSG_SKILL")
  --self:RegisterEvent("BAG_UPDATE")

  local chatevents = {
    "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER", "CHAT_MSG_GUILD_ACHIEVEMENT",
    "CHAT_MSG_CHANNEL", "CHAT_MSG_SAY", "CHAT_MSG_YELL", 
    "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM",
    "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", 
    "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING",
    "CHAT_MSG_DND", "CHAT_MSG_AFK", "CHAT_MSG_EMOTE", "CHAT_MSG_TEXT_EMOTE",
    "CHAT_MSG_BATTLEGROUND", "CHAT_MSG_BATTLEGROUND_LEADER", 
  }
  for _,chatevent in pairs(chatevents) do
    self:RegisterEvent(chatevent, "CHAT_MSG_X")
  end

  addon:ADDON_LOADED() -- in case we are loaded late

  if true then
    local tthooks = {
	"SetAuctionItem", "SetAuctionSellItem", 
	"SetExistingSocketGem", "SetSocketGem", "SetGlyph", "SetSpellByID",
	"SetHyperlink", "SetAction",
	"SetBagItem", "SetGuildBankItem", "SetInventoryItem",
	"SetTradePlayerItem", "SetTradeSkillItem",
	"SetLootItem", "SetLootRollItem", 
	"SetMerchantItem", "SetBuybackItem", 
	"SetSendMailItem", "SetInboxItem", 	
    }
    for _,hook in pairs(tthooks) do
      hooksecurefunc(GameTooltip, hook, PV_ShowTooltip)
    end
    hooksecurefunc(addon.scantt, "SetHyperlink", PV_ShowTooltip)
    if AtlasLootTooltip then
      hooksecurefunc(AtlasLootTooltip, "SetHyperlink", PV_ShowTooltip)
      if AtlasLootTooltip.HookScript then -- all this just to help it resize properly
        local resizedammit = function () 
	  AtlasLootTooltip:SetSize(AtlasLootTooltip:GetSize())
	  AtlasLootTooltip:Show()
	end
        AtlasLootTooltip:HookScript("OnTooltipSetItem", resizedammit)
        AtlasLootTooltip:HookScript("OnTooltipSetSpell", resizedammit)
        AtlasLootTooltip:HookScript("OnSizeChanged", resizedammit)
        AtlasLootTooltip:HookScript("OnUpdate", resizedammit)
      end
    end
    hooksecurefunc("SetItemRef", PV_ShowItemRefTooltip)
    hooksecurefunc("GetGuildMemberRecipes", function () addon.lastTSL = nil end)
    hooksecurefunc("CastSpell", PV_CastSpellHook)
    hooksecurefunc("CastSpellByID", PV_CastSpellHook)
    hooksecurefunc("CastSpellByName", PV_CastSpellHook)
    hooksecurefunc("UseAction", PV_UseActionHook)
  else
    GameTooltip:HookScript("OnTooltipSetItem", PV_ShowTooltip)
    ItemRefTooltip:HookScript("OnTooltipSetItem", PV_ShowTooltip)
    if AtlasLootTooltip and AtlasLootTooltip.HookScript then
      AtlasLootTooltip:HookScript("OnTooltipSetItem", PV_ShowTooltip)
    end
  end


  if not DBc.data.scanned then -- no professions registered on this toon
    addon:Scan()
  else
    addon:ScanSecondary() -- does not capture primary profs during static load because GetSpellLink is not yet functional
  end

  local chatframes = { [DEFAULT_CHAT_FRAME] = true }
  for i=1,50 do 
    local f = _G["ChatFrame"..i]
    local g = _G["ChatFrame"..i.."EditBox"]
    if not f then break end
    chatframes[f] = true
    --debug("Hooking ChatFrame"..i)
    --if g then chatframes[g] = true end
  end
  for f,_ in pairs(chatframes) do
    f:HookScript("OnHyperlinkEnter", function(self, linkData, olink) 
        if settings.chattooltips and string.match(linkData,"^trade:") then 
	  --printlink(olink)
          local link, pname, spell = addon:normalize_link(olink)
	  local rank, rankmax = addon:link_rank(link)
	  local texstr = "|T"..allProf[pname].icon..":0|t  "
	  GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
	  if rank == 0 then
	    GameTooltip:SetText(texstr..pname)
	    GameTooltip:AddLine("    "..einstein)
	  else
	    GameTooltip:SetText(texstr..pname.." ("..rank.."/"..rankmax..")")
	    local guid, cname = addon:link_cnameguid(link)
	    if cname then GameTooltip:AddLine("    "..cname) end
	    local rcnt = addon:link_bit_count(link)
	    if rcnt > 0 then GameTooltip:AddLine("    "..rcnt.." "..L["recipes"]) end
	  end
	  GameTooltip:Show()
	end 
    end)
    f:HookScript("OnHyperlinkLeave", function(self, linkData, link) 
        if settings.chattooltips and string.match(linkData,"^trade:") then 
	  GameTooltip:Hide()
	end 
    end)
  end

  PVLDB = LDB:NewDataObject(addonName, {
        type = "data source",
        label = addonName,
        --icon = "Interface\\Icons\\spell_shadow_mindtwisting",
        --icon = "Interface\\Icons\\inv_misc_enggizmos_17",
        icon = "Interface\\Icons\\inv_scroll_03",
        OnClick = function(self, button)
                if button == "MiddleButton" then
			addon:Config()
                elseif button == "RightButton" and settings.ldbprof and not nocastProf[settings.ldbprof] then
		  	addon:ActivateLink(charName, settings.ldbprof, DBc[settings.ldbprof] and DBc[settings.ldbprof].link, true)
                else
                        addon:ToggleWindow()
                end
        end
  })
  PVLDB.OnTooltipShow = function(tooltip)
	debug("LDB:OnTooltipShow "..(tooltip and tooltip == GameTooltip and "" or "not ").."GameTooltip")
	PVLDB.OnEnter(tooltip:GetOwner())
  end
  PVLDB.OnEnter = function(self)
        debug("PVLDB:OnEnter")
	addon:ScanSecondary()
	PVLDBTT = PVLDBTT or CreateFrame("GameTooltip", "PVLDBTT", UIParent, "GameTooltipTemplate")
	local tt = PVLDBTT
   	tt:SetOwner(self, "ANCHOR_NONE")
	tt:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	tt:ClearLines()
	addon:fillLDB(tt)
        tt:EnableMouse(true)
	tt:Show()
	--GameTooltip:SetScript("OnMouseDown",function(self,button) addon:LDBclick(self,button) end)
        -- must use a button for OnClick hardware event to CastSpellByName
        PVLDBButton = PVLDBButton or CreateFrame("Button", "PVLDBButton", tt)
        PVLDBButton:SetAllPoints(tt)
	PVLDBButton:SetScript("OnClick",function(self,btn) addon:LDBclick(tt,btn) end)
        PVLDBButton:RegisterForClicks("AnyDown")
        PVLDBButton:SetScript("OnLeave", function() tt:Hide() end)
  end
  PVLDB.OnLeave = function() 
        debug("PVLDB:OnLeave")
	if PVLDBTT and not PVLDBTT:IsMouseOver() then
	   PVLDBTT:Hide()
	end
  end

  settings.minimap = settings.minimap or {}
  minimapIcon:Register(addonName, PVLDB, settings.minimap)
  if settings.minimap.hide then
    minimapIcon:Hide(addonName)
  else
    minimapIcon:Show(addonName)
  end
  SetLDBProf()

end

local ldb_myprof_line = 1
local ldb_einstein_line = 1
function addon:fillLDB(tooltip)
  local ttname = tooltip:GetName()
  tooltip:SetText(addonName.." "..ProfessionsVault.version)
  tooltip:AddLine("|cffff8040"..L["Left Click"].."|r "..L["to toggle the window"])
  tooltip:AddLine("|cffff8040"..L["Middle Click"].."|r "..L["for config"])
  if settings.ldbprof and not nocastProf[settings.ldbprof]  then
    tooltip:AddLine("|cffff8040"..L["Right Click"].."|r "..L["to open"].." "..settings.ldbprof)
  end
  if not DBc then return end
  tooltip:AddLine(" ")
  tooltip:AddLine("|cffff8040"..L["My Professions"]..":|r")
  ldb_myprof_line = tooltip:NumLines() 
  for _,pname in ipairs(allProfSorted) do
      local pinfo = DBc[pname]
      if (pinfo and not addon:isHidden(charName,pname)) then
        local rank = pinfo.rank or "??"
        local rankmax = pinfo.rankmax or "??"
        local texstr = "|T"..allProf[pname].icon..":0|t"
        tooltip:AddDoubleLine(texstr.." ["..pname.."]","("..rank.."/"..rankmax..")")
        --tooltip:AddTexture(allProf[pname].icon)
      end
  end
  tooltip:AddLine(" ")
  tooltip:AddLine("|cffff8040"..einstein..":|r")
  ldb_einstein_line = tooltip:NumLines() 
  for _,pname in ipairs(allProfSorted) do
      local pinfo = DB.chars[einstein][pname]
      if (pinfo and pinfo.link) then
        local texstr = "|T"..allProf[pname].icon..":0|t"
        tooltip:AddDoubleLine(texstr.." ["..pname.."]"," ")
        --tooltip:AddTexture(allProf[pname].icon)
      end
  end
  
end
function addon:LDBclick(tt,button)
   local ttname = tt:GetName()
   debug("LDBclick "..ttname)
   local gotone = false
   for i=ldb_myprof_line,tt:NumLines() do
     local lline = getglobal(ttname .. "TextLeft"..i)
     if not lline then return end
     local text = lline:GetText()
     if not text then return end
     local pname = string.match(text,"%[(.*)%]")
     if pname and lline:IsMouseOver(0,0,-500,500) then
         local cname = (i >= ldb_einstein_line) and einstein or charName
         local link = DB.chars[cname][pname].link
         debug("LDBclicked on "..pname.." "..link)
         addon:ActivateLink(cname, pname, link, true)
         gotone = true
     end   
   end
   if not gotone then
     PVLDB:OnClick(button)
   end
   --tt:Hide()
end
-- ----------------------------------------------------------------------------------
-- ticket 40: German client uses weird replacement strings
-- enUS/GB: Your skill in %s has increased to %d.
-- deDE: Eure Fertigkeit '%1$s' hat sich auf %2$d erhöht.
-- esES: Tu habilidad en %s ha subido a %d p.
-- frFR: Votre compétence en %s est maintenant de %d.
-- ruRU: %s ?????????? ?? %d.
local m_skillup = string.gsub(SKILL_RANK_UP,"%%%d*\$?[sd]","\(\.\*\)")
local m_patlearn = string.gsub(ERR_LEARN_RECIPE_S,"%%s","\(\.\*\)")
local m_proflearn = string.gsub(ERR_SKILL_GAINED_S,"%%s","\(\.\*\)")
local m_profunlearn = string.gsub(ERR_SPELL_UNLEARNED_S,"%%s","\(\.\*\)")
local function processSystemMessage(msg)
  --myprint(msg) ; printlink(msg)
  local rescan = false
  local skillprof, skillrank = string.match(msg, m_skillup)
  local patlearn    = string.match(msg, m_patlearn)
  local proflearn   = string.match(msg, m_proflearn)
  local profunlearn = string.match(msg, m_profunlearn)
  if skillrank and allProf[skillprof] then
    skillrank = tonumber(skillrank)
    debug("Detected skill up: "..skillprof.." "..skillrank)
    rescan = skillprof
  elseif patlearn then
    debug("Detected pattern learn: "..patlearn)
    rescan = true
  elseif proflearn and allProf[proflearn] then
    debug("Detected profession learn: "..proflearn)
    rescan = proflearn
  elseif profunlearn then
    local spellid = string.match(profunlearn, "|Hspell:(%d+)|h")
    spellid = spellid and tonumber(spellid)
    local unlearn_aliases = { -- some profs done have a clean unlearn spellid
      [2366] = PID_HERB,
    }
    spellid = (spellid and unlearn_aliases[spellid]) or spellid
    local spellname = spellid and GetSpellInfo(spellid)
    if allProf[spellname] and DBc[spellname] then
      debug("Detected profession unlearn: "..profunlearn)
      DBc[spellname] = nil
      SetLDBProf(nil)
      -- cannot rescan here because GetSpellLink still returns the prof
    end
  end
  if rescan then
    --[[
    if GetTradeSkillLine() ~= "UNKNOWN" and not IsTradeSkillLinked() then
        local rchange, schange = addon:UpdateTrade()
	if rchange == 1 then -- correct window was open and we autoscanned it
	  return
	end
    end --]]
        --local orank = string.match(DBc[profname].link, "\124Htrade:%d+:(%d+):")
        --DBc[profname].link = string.gsub(DBc[profname].link, "(\124Htrade:%d+:)%d+:", "%1"..nrank..":")
	--chatMsg(format(L["Updated %s's %s"].." (%s "..L["skill points"]..")", charName, profname, (nrank-orank)))
    local rchange, schange, profchange = addon:ScanSecondary()
    --print(rchange.." : "..schange)
    if (rchange == 0) and (schange == 0) then -- failed?
      DBc.data.scanned = false
      --addon:Scan()
    end
    if allProf[rescan] then 
       SetLDBProf(rescan) 
    elseif profchange and allProf[profchange] then
       SetLDBProf(profchange) 
    end
  end
end

function addon:CHAT_MSG_SKILL(event, msg, ...)
  --myprint(event, msg, ...) ; printlink(msg)
  processSystemMessage(msg)
end
function addon:CHAT_MSG_SYSTEM(event, msg, ...)
  --myprint(event, msg, ...) ; printlink(msg)
  processSystemMessage(msg)
end
-- ----------------------------------------------------------------------------------

local function guid_compress(guid)
  if not guid then return nil end
  local res = string.gsub(guid, "^0x","")
  res = string.rep("0",16-#res)..res -- leading zeros get lost in some contexts
  local guid_prefix
  guid_prefix, res = string.match(res, "^(%x%x%x)0+(%x+)$")
  if not res then return nil end
  if guid_prefix ~= DB.guid_prefix then
    debug("Updating guid_prefix "..(DB.guid_prefix or "nil").." => "..guid_prefix)
    DB.guid_prefix = guid_prefix
  end
  --print(DB.guid_prefix.."   "..guid)
  res = tonumber(res, 16)
  return res
end
local function guid_expand(guid)
  if not guid then return nil end
  local bits = format("%X",guid)
  guid = DB.guid_prefix .. string.rep("0",13-#bits) .. bits
  return guid
end
function addon:update_guid_cache(name, guid)
  if UnitIsInMyGuild(name) then
    guid = guid_compress(guid)
    local oldval = DB.guid_cache[name]
    local changed
    if not oldval then
      if debug then debug("Saving new guid "..name.." "..guid_expand(guid)) end
      changed = true
    elseif oldval ~= guid then
      if debug then debug("Updating guid "..name.." "..guid_expand(oldval).." => "..guid_expand(guid)) end
      changed = true
    end
    if changed then
      DB.guid_cache[name] = guid
      local isLinked, cname = IsTradeSkillLinked()
      if cname and cname == name and GetTradeSkillLine() ~= "UNKNOWN" then -- just got the GUID for a guild trade
        addon:UpdateTrade()
	addon:TSLupdate()
      end
    end
  end
end
function addon:link_cnameguid(link)
   if not link then return end
   local guid = string.match(link,"\124Htrade:%d+:%d+:%d+:(%x+):")
   if not guid or #guid < 10 then return end
   local cname = select(6,GetPlayerInfoByGUID(guid)) -- sometimes failed if not encountered by client
   return guid, cname
end
function addon:update_guid_cache_fromlink(link)
   local guid, cname = addon:link_cnameguid(link)
   if cname and guid then addon:update_guid_cache(cname, guid) end
end

function addon:CHAT_MSG_X(event, msg, sender, _,_,_,_,_,_,_,_, counter, guid)
  addon:update_guid_cache(sender, guid)
end

-- show the TradeSkillLinkButton when we can
function addon:TSLupdate() 
  if addon.lastTSL and not IsTradeSkillGuild() and 
     not TradeSkillLinkButton:IsVisible() and
     not nolinkProf[GetTradeSkillLine()] then
    TradeSkillLinkButton:Show()
  end
end

-- wrap GetTradeSkillListLink to return our link for Blizzard_TradeSkillUI
local function wrap_GetTradeSkillListLink()
  if addon.lastTSL and TradeSkillLinkButton:IsVisible() and not nolinkProf[GetTradeSkillLine()] then 
    return addon.lastTSL
  else
    return GetTradeSkillListLink()
  end
end
local function TSLpreclick() 
  _G.GetTradeSkillListLink = wrap_GetTradeSkillListLink 
end
local function TSLpostclick() 
  _G.GetTradeSkillListLink = GetTradeSkillListLink 
end
local function TradeSkillLinkDropDown_LinkPost(self, chan)
  local link = wrap_GetTradeSkillListLink();
  if link then
    ChatFrame_OpenChat(chan.." "..link, DEFAULT_CHAT_FRAME);
  end
end

local function TSLNhide() 
  local pname, rank, rankmax = GetTradeSkillLine()
  local isLinked, name = IsTradeSkillLinked()
  if rankmax > 0 and (isLinked and name == charName) 
     and addon.lastTSL then -- einstein ranks get corrupted for profs we have
     rank, rankmax = addon:link_rank(addon.lastTSL) 
  end
  if rankmax == 0 then
     if TradeSkillLinkNameButton and TradeSkillLinkNameButton:IsVisible() then
       TradeSkillLinkNameButton:Hide()
       debug(TradeSkillLinkNameButton:GetName()..":Hide()")
     end
     if TradeSkillRankFrame and TradeSkillRankFrame:IsVisible() then
       TradeSkillRankFrame:Hide()
       debug(TradeSkillRankFrame:GetName()..":Hide()")
     end
     if TradeSkillFrameTitleText then
       TradeSkillFrameTitleText:SetText(pname.." ("..einstein..")")
     end
  end
end

-- fires when the name is updated late on a guild-opened trade skill ui
function addon:TRADE_SKILL_NAME_UPDATE()
  debug("TRADE_SKILL_NAME_UPDATE")
  addon:TRADE_SKILL_SHOW()
end

function addon:TRADE_SKILL_SHOW()
  debug("TRADE_SKILL_SHOW")
  addon:UpdateTrade()
  if TradeSkillLinkNameButton and not addon.tslnhook then
    TradeSkillLinkNameButton:HookScript("OnUpdate", TSLNhide)
    addon.tslnhook = true
  end
  if TradeSkillRankFrame and not addon.tsrfhook then
    TradeSkillRankFrame:HookScript("OnUpdate", TSLNhide)
    addon.tsrfhook = true
  end
  if TradeSkillFrame_SetSelection and TradeSkillLinkButton and not addon.tssshook then
    addon.tssshook = true
    hooksecurefunc("TradeSkillFrame_SetSelection", function() addon:TSLupdate() ; TSLNhide() end)
    TradeSkillLinkButton:HookScript("PreClick", TSLpreclick)
    TradeSkillLinkButton:HookScript("PostClick", TSLpostclick)
    _G.TradeSkillLinkDropDown_LinkPost = TradeSkillLinkDropDown_LinkPost
  end
  addon:TSLupdate()
  if UnitIsDead("player") and not TradeSkillFrame:IsVisible() 
     and not GnomeWorksFrame and not SkilletFrame then
    -- TradeSkillFrame refuses to open while dead and unreleased, which is retarded
    UIErrorsFrame:Clear()
    TradeSkillFrame:Show()
  end
end

function addon:SaveButton()
  local button = addon.savebutton
  if not button then
     button = CreateFrame("Button",addonName.."SaveButton",TradeSkillFrame,"UIPanelButtonTemplate")
     addon.savebutton = button
     button:SetText(L["Save"])
     if TradeSkillCancelButton then
        button:SetSize(TradeSkillCancelButton:GetSize())
     else
        button:SetSize(80,22)
     end
     button:SetMotionScriptsWhileDisabled(true)
     button:SetScript("OnMouseUp", function (self,btn,down) 
       debug("Save Button pushed")
       if (button:IsEnabled()) then
         addon:UpdateTrade(true) 
       elseif addon.savecname then
         ChatFrame_SendTell(addon.savecname)
       end
     end)
     button:SetScript("OnEnter", function (self) 
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
        if (button:IsEnabled()) then
          GameTooltip:SetText(L["Save this trade skill to ProfessionsVault"]);
	else
          GameTooltip:SetText(format(L["Send a whisper to %s to activate this button"],addon.savecname or ""));
	end
        GameTooltip:Show()
     end)
     button:SetScript("OnLeave", function (self) GameTooltip:Hide() end)
     --[[
     button.Disable = function() 
       button.enabled = false
       button.oldtex = button:GetNormalTexture()
       button.oldfont = button:GetNormalFontObject()
       if button:GetDisabledTexture() then
         button:SetNormalTexture(button:GetDisabledTexture()) 
       end
       if button:GetDisabledFontObject() then
         button:SetNormalFontObject(button:GetDisabledFontObject()) 
       end
     end
     button.Enable = function() 
       button.enabled = true;
       if (button.oldtex) then button:SetNormalTexture(button.oldtex) end
       if (button.oldfont) then button:SetNormalFontObject(button.oldfont) end
     end
     ]]
  end
  return button
end
function addon:SaveButtonShow()
      local button = addon:SaveButton()
      if Skillet and SkilletFrame then 
        button:SetParent(SkilletFrame)
	if SkilletPluginButton then
          button:SetPoint("TOPLEFT",SkilletPluginButton,"TOPRIGHT",1,0)
	  button:SetSize(SkilletPluginButton:GetSize())
        end 
      --[[ -- cant use this interface because skilet makes very narrow assumptions about how plugin buttons work
        local frame = Skillet:AddButtonToTradeskillWindow(button)
	Skillet:PluginButton_OnClick()
	button:SetScript("OnClick", function() end)
	]]
      elseif GnomeWorksFrame then
        button:SetParent(GnomeWorksFrame)
	button:SetPoint("BOTTOMLEFT",25,5)
      elseif MRTSkillFrame then
        button:SetParent(MRTSkillFrame)
	button:SetPoint("BOTTOMLEFT",165,4)
      else
        button:SetParent(TradeSkillFrame)
        button:SetPoint("BOTTOMLEFT",5,5)
      end
      button:Enable()
      button:Show()
      local lvl = (button:GetParent() and button:GetParent():GetFrameLevel()+1) or 1000
      button:SetFrameLevel(lvl)
end

function addon:UpdateTrade(force)
  addon:SaveButton():Hide()
  if IsTradeSkillGuild() then return end -- guild "view all" trade
  local pname, rank, rankmax = GetTradeSkillLine()
  local link = addon:normalize_link(GetTradeSkillListLink())
  if not link and nolinkProf[pname] then
    if not addon.smeltwarning and (pname == GetSpellInfo(PID_MINE) or pname == GetSpellInfo(PID_SMELT)) then
        chatMsg(format(L["Warning: Tradeskill %s has no link available to be used."]..
	               " "..L["This is a known Blizzard bug."],pname));
	addon.smeltwarning = true
    end
    return
  end
  local linked, cname = IsTradeSkillLinked()
  local class, race  -- for linked only
  addon:update_guid_cache_fromlink(link)
  if not linked then
    cname = charName
  elseif not link then -- guild trade window
    debug("Guild Tradeskill: "..(cname or "NIL").." "..(pname or "NIL"))
    -- cname will occasionally arrive after the SHOW event
    if not pname or 
      cname and cname == charName then
      force = false
    elseif nolinkProf[pname] then -- mining
      force = false
    else
      addon:SaveButtonShow()
      if not cname or not DB.guid_cache[cname] then
        addon:SaveButton():Disable()
	addon.savecname = cname
	force = false
      elseif not addon.lastTSL then
        addon.lastTSL = addon:normalize_link(addon:BuildGuildTradeLink())
	debug("Set addon.lastTSL = "..(addon.lastTSL or "nil").." ("..addon:hash(addon.lastTSL)..")")
      end
    end
    if force then
      link = addon.lastTSL
      if not link then 
        force = false
      else
        linked = true
        local guid = guid_expand(DB.guid_cache[cname])
        if guid then
          class,_,_,race,_,guidname = GetPlayerInfoByGUID(guid)
        end
        race = race or UnitRace("player") -- fake it to get faction
      end
    end

    if not force then
      debug("Ignoring "..(cname or "NIL").."'s "..(pname or "NIL"));
      return
    end
  else -- linked trade window
    local spellid, guid, guidname
    link = addon:normalize_link(addon.lastTSL)
    if link then
      spellid, guid = string.match(link,"\124Htrade:(%d+):%d+:%d+:(%x+):")
    end
    if spellid and guid then 
      class,_,_,race,_,guidname = GetPlayerInfoByGUID(guid)
      local guidspell = GetSpellInfo(spellid)
      if guidname == charName or guidname ~= cname or guidspell ~= pname then force = false end
    else
      force = false 
    end
    if link and guidname and guidname ~= charName then
      addon:SaveButtonShow()
    end
    if not force then
      debug("Ignoring "..(cname or "NIL").."'s "..pname);
      return
    end
  end
  if (not pname or pname == "UNKNOWN") then
    return
  end
    if not allProf[pname] then
      chatMsg("ERROR: unrecognized profession: "..pname)
    end

    if not DB.chars[cname] then
      DB.chars[cname] = {}
    end
    local dbc = DB.chars[cname]
    if linked then
      dbc.data = dbc.data or {}
      dbc.data.name = cname
      local allianceRace = {
         ["Human"]=true, ["Dwarf"]=true, ["Gnome"]=true, ["NightElf"]=true, ["Draenei"]=true, ["Worgen"]=true
      }
      dbc.data.class = class
      dbc.data.faction = UnitFactionGroup(cname) -- may fail
                         or (race and ((allianceRace[race] and "Alliance") or "Horde"))
      local level = UnitLevel(cname) -- may fail
      if level > 0 then
        dbc.data.level = level
      end
    end
  return addon:SaveLink(cname, pname, link)
end
function addon:SaveLink(cname, pname, link)
    local dbc = DB.chars[cname]
    local changestr = nil
    local rchange, schange = 0, 0
    local newr, newrmax = addon:link_rank(link)
    if not dbc[pname] then
      changestr = L["Saved %s's %s"]
      if link and allProf[pname].patlen > 1 then 
        local cnt = addon:link_bit_count(link)
        changestr = changestr.." ("..cnt.." "..L["recipes"]..")"
	rchange = cnt
      end
      schange = newr
    elseif dbc[pname].link ~= link then
      changestr = L["Updated %s's %s"]
      if link and dbc[pname].link then 
        local oldcnt = addon:link_bit_count(dbc[pname].link)
        local newcnt = addon:link_bit_count(link)
	local oldr = addon:link_rank(dbc[pname].link)
	local diffstr = ""
	if (newcnt ~= oldcnt) then
	  rchange = (newcnt-oldcnt)
	  diffstr = rchange.." "..L["recipes"]
	end
	if (oldr ~= newr) then
	  schange = (newr - oldr)
	  diffstr = diffstr..((#diffstr > 0 and ", ") or "")..schange.." "..L["skill points"]
	end
	if #diffstr > 0 then
          changestr = changestr.." ("..diffstr..")"
	else
	  changestr = nil
	end
      else
        schange = newr
      end
    end
    dbc[pname] = {}
    dbc[pname].link = link
    dbc[pname].rank = newr
    dbc[pname].rankmax = newrmax
    dbc[pname].lastupdate = time()
    local _, clientbuild,_,uiversion = GetBuildInfo()
    dbc[pname].clientbuild = (tonumber(clientbuild) or 0)
    dbc[pname].uiversion = (tonumber(uiversion) or 0)
    debug("Processed "..cname.."'s "..pname);
    if changestr then
      if settings.updatemsg then
        chatMsg(format(changestr,cname,pname));
      end
      addon:RefreshWindow()
    end
    addon:RefreshTooltips()
    return rchange, schange
end

-- traversal function for character table
local cnext_sorted_names = {}
local function cnext(t,i)
   -- return them in reverse order
   if #cnext_sorted_names == 0 then 
     return nil
   else
      local n = cnext_sorted_names[#cnext_sorted_names]
      table.remove(cnext_sorted_names, #cnext_sorted_names)
      return n, t[n]
   end
end
local function cpairs(t)
  cnext_sorted_names = {}
  for n,_ in pairs(t) do
    table.insert(cnext_sorted_names, n)
  end
  table.sort(cnext_sorted_names, function (a,b) return b == charName or (a ~= charName and a > b) end)
  --myprint(cnext_sorted_names)
  return cnext, t, nil
end

function addon:Dump()
  for cname,dbc in cpairs(DB.chars) do
    local data = dbc.data or {}
    chatMsg("-=- "..cname.." "..(data.level or "").." "..
            ((data.faction and LFaction[data.faction]) or "")..
	    " "..(data.class or "").." -=-")
    for _,pname in ipairs(allProfSorted) do
      if (dbc[pname]) then
        local pinfo = dbc[pname]
        local rank = pinfo.rank or "??"
        local rankmax = pinfo.rankmax or "??"
	local link = pinfo.link or "["..pname.."]"
        chatMsg(" "..link.."   ("..rank.."/"..rankmax..")")
      end
    end
  end
end

local function OnClose(widget)
  debug("OnClose")
  widget.frame:SetFrameStrata(widget.acegui_strata)
  addon:clearEscapeHandler(widget)
  addon:decustomizeLayout(widget)
  if settings.locked then
    addon:unlockWidget(addon.gui)
  end
  AceGUI:Release(widget)
  addon.gui = nil
end

local function cleanlink(link)
  local res = string.match(link,"|H(trade:[^|]+)|h")
  if not res then
    res = link
  end
  debug("cleanlink("..link..") => ".. res)
  return res
end

function addon:dirtylink(cl)
  local ret = cleanlink(cl)
  ret = "\124cffffd000\124H"..ret.."\124h[Foo]\124h\124r"
  ret = addon:normalize_link(ret)
  return ret
end

function addon:ActivateLink(cname,pname,link,nodropdown)
  if cname == allexpand or pname == allexpand then return end
  debug("ActivateLink: "..cname.." "..(pname or ""))
  if GetMouseButtonClicked() == "RightButton" and not nodropdown then
     addon:ShowDropdown(cname, pname)
  else
  if pname == GetSpellInfo(PID_MINE) then
     pname = GetSpellInfo(PID_SMELT) 
  end
  if IsShiftKeyDown() then
    local activeEditBox = ChatEdit_GetActiveWindow();

    if cname and not pname then -- all we have is a toon name
      if cname == einstein then return end
      if activeEditBox then
        ChatEdit_InsertLink(cname)
      else
        ChatFrame_SendTell(cname)
      end
      return
    end

    if pname and (not link or nolinkProf[pname]) then
        --chatMsg(format(L["Warning: Tradeskill %s has no link available to be used."].." "..
	--               L["This is a known Blizzard bug."],pname));
        link = addon:spellLink(pname)
    end
    if link then 
       if activeEditBox then
          ChatEdit_InsertLink(link) 
       else
          ChatFrame_OpenChat(link, DEFAULT_CHAT_FRAME)
       end
    end
  else
    if not pname then
      return
    elseif cname == charName then
      if not nocastProf[pname] then
        debug("CastSpellByName("..pname..")")
        CastSpellByName(pname)
      end
    else
      local name, rank, rankmax = GetTradeSkillLine()
      local linked, linkedName = IsTradeSkillLinked()
      if linked and (linkedName == cname or (linkedName == charName and cname == einstein))
         and name and name == pname then -- already open so close it
        CloseTradeSkill()
      elseif nolinkProf[pname] then
        if not nocastProf[pname] then
          chatMsg(format(L["Warning: Tradeskill %s has no link available to be used."]..L["This is a known Blizzard bug."],pname));
        end
      else -- open it (undocumented API - sshhh)
	addon.lastTSL = link
        SetItemRef(cleanlink(link),link,"LeftButton",ChatFrame1)
      end
    end
  end
  if settings.autoclose and addon.gui then
    addon.gui:Hide()
  end
  end
end

function addon:ScanProfessions()
  local scantime = time()
  debug("ScanProfessions")
  CloseTradeSkill()
  addon:RefreshChar()
  local gotone = false
  for p in pairs(allProf) do
    if (allProf[p].patlen > 0) then
      CastSpellByName(p) 
      CloseTradeSkill()
      if DBc[p] and DBc[p].lastupdate >= scantime then
        gotone = true
      end
    end
  end
  addon:ScanSecondary()
  if gotone then
    chatMsg(L["Profession Scan complete!"])
  else
    chatMsg(L["No professions detected! (try again later?)"])
  end
  DBc.data.scanned = true 
  addon:RefreshWindow()
end

function addon:ScanSecondary()
  debug("addon:ScanSecondary()")
  local gotr,gots,gotprof = 0,0,nil
  --local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
  local myprofids = { GetProfessions() }
  for _,profid in pairs(myprofids) do
    local pname, texture, rank, rankmax, numSpells, spelloffset, skillLine, rankModifier = GetProfessionInfo(profid)
    debug(pname.." "..rank.."/"..rankmax.." "..rankModifier) 
    local pinfo = allProf[pname]
    local link
    if pinfo and pinfo.patlen > 1 then
      local _,rawlink = GetSpellLink(pname)
      link = addon:normalize_link(rawlink)
      local oldlink = DBc and DBc[pname] and DBc[pname].link
      if not link or link == oldlink then
        link = nil
      end
    elseif pinfo then -- non-tradeskill profession
      link = addon:fakeLink(pname, 0, allProf[pname].spellid, rank, rankmax, 0)
    end
    if link then
      local rchange, schange = addon:SaveLink(charName, pname, link)
      gotr = gotr + rchange 
      gots = gots + schange 
      if rchange > 0 then
        gotprof = pname
      end
    end
  end
  return gotr, gots, gotprof
end

local function ProfTooltip(frame, cname, pname, pinfo)
   if not frame then
     debug("Missing frame on ProfTooltip")
     return
   end
   addon.gui:SetStatusText(cname.." / "..pname)
   if not settings.tooltips then 
     return
   end
   local linkprof = not nolinkProf[pname]
   --GameTooltip:SetOwner(frame, "ANCHOR_CURSOR"); 
   GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT"); 
   local caveat = ""
   if cname == einstein then
     local txt = pname
     if linkprof then
       txt = txt.." ("..einstein..")"
     end
     GameTooltip:SetText(txt); 
     caveat = "<= "
   else
     GameTooltip:SetText(cname .." ".. pname.." ("..pinfo.rank.." / "..pinfo.rankmax..")"); 
   end
   if (linkprof and pinfo and pinfo.link and allProf[pname].patlen > 1) then
       local cnt = addon:link_bit_count(pinfo.link)
       GameTooltip:AddLine(caveat..cnt.." "..L["recipes"])
   end
   local text =  chardatastr(cname)
   if #text then
     GameTooltip:AddLine(text)
   end
   if pinfo and pinfo.lastupdate then
     GameTooltip:AddLine("|cff00ff00"..L["Last Scan"]..": "..date(nil,pinfo.lastupdate).."|r")
   end
   if linkprof then
     GameTooltip:AddLine("|cffff8040"..L["Left Click"].."|r "..L["to open"])
     GameTooltip:AddLine("|cffff8040"..L["Shift Left Click"].."|r "..L["to link in chat"])
   end
   GameTooltip:AddLine("|cffff8040"..L["Right Click"].."|r "..L["for menu"])
   GameTooltip:Show() 
end

local function ProfIcon(cname,pname,pinfo,label,img)
  local icon = AceGUI:Create("Icon")
  if img and string.find(img,"BattlefieldFrame") then
    icon:SetImage(img or allProf[pname].icon, 0.2,0.8,0.2,0.8)
  else
    icon:SetImage(img or allProf[pname].icon)
  end
  icon.frame:RegisterForClicks("AnyDown") -- cheat to get right-clicks too
  local events = {
    ["OnClick"] = function(button) addon:ActivateLink(cname,pname,pinfo and pinfo.link) end,
    ["OnEnter"] = function(button) ProfTooltip(button.frame, cname, pname, pinfo) end,
    ["OnLeave"] = function(button) addon.gui:SetStatusText(""); GameTooltip:Hide() end,
    }
  for evt, hnd in pairs(events) do
    icon:SetCallback(evt, hnd)
  end
  if label then -- must use Icon or Button to get OnClick hardware event for CastSpellByName
    local grp = AceGUI:Create("SimpleGroup")
    --grp:SetFullWidth(true)
    grp:SetWidth(300)
    grp:SetLayout("Flow")
    grp:SetHeight(24)
    icon:SetImageSize(18,18)
    icon:SetHeight(24)
    icon:SetWidth(24)
    grp:AddChild(icon)
    local text = AceGUI:Create("Icon")
    text:SetImageSize(150,24)
    text:SetWidth(150)
    text:SetLabel(label)
    text.label:ClearAllPoints() -- hack
    text.label:SetPoint("BOTTOMLEFT") -- hack
    text.label:SetJustifyH("LEFT") -- hack
    text:SetHeight(24)
    --text.frame:GetHighlightTexture():SetAllPoints(text.label)
    text.frame:RegisterForClicks("AnyDown") -- cheat to get right-clicks too
    for evt, hnd in pairs(events) do
      text:SetCallback(evt, hnd)
    end
    grp:AddChild(text)
    return grp
  else
    icon:SetWidth(48)
    icon:SetHeight(48)
    icon:SetImageSize(36,36)
    return icon
  end
end

local function MakeButton(text, fn) 
  local button = AceGUI:Create("Button")
  button:SetText(text)
  button:SetWidth(7.5*string.len(text)+50)
  button:SetCallback("OnClick",fn)
  return button
end

local function parsePath(path)
  local cname, pname = ("\001"):split(path)
  if settings.grpbyprof then
    return pname, cname
  else
    return cname, pname
  end
end

local function OnSelect(widget, event, value)
  if value == allexpand then
    local newval = not addon.tree.status.groups[allexpand]
    addon.tree.status.selected = nil
    if settings.treepath then
      activateontree = false
      addon.tree:SelectByPath((newval and unpack(settings.treepath)) or settings.treepath[1])
      activateontree = true
    end
    local grps = addon.tree.status.groups
    local tree = addon.tree.tree
    if grps and tree then
      for _,t in pairs(tree) do
        if t.value == allexpand then
	  t.icon = (newval and allexpandminus) or allexpandplus
	end
        grps[t.value] = newval
      end
      addon.tree:RefreshTree()
    end
    addon:FixStrata()
    return
  end
  local cname, pname = parsePath(value)
  local pathtxt = strjoin(" / ",("\001"):split(value))
  local hidone = false
  settings.treepath = { ("\001"):split(value) }
  addon.gui:SetStatusText(pathtxt)
  debug("OnSelect: "..pathtxt)

    widget:ReleaseChildren()
    widget:SetLayout("List") 
    -- body for a character

    local scroller = AceGUI:Create("ScrollFrame")
    scroller:SetLayout("List")
    scroller:SetHeight(0) -- prevents a nasty graphical bug, dont ask me why
    scroller:SetFullHeight(true)
    scroller:SetFullWidth(true)

  if settings.grpbyprof then
    --local grp = AceGUI:Create("SimpleGroup")
    --grp:SetLayout("List")
    --grp:SetWidth(250)
    --grp:SetFullWidth(true)
    local label = AceGUI:Create("InteractiveLabel")
    label:SetFullWidth(true)
    --label:SetWidth(240)
    label:SetImage(allProf[pname].icon)
    label:SetImageSize(32,32)
    label:SetFontObject(headerfont)
    label:SetText(pname.."\n")
    local einfo = DB.chars[einstein][pname]
    label:SetCallback("OnClick", function() addon:ActivateLink(einstein,pname,einfo and einfo.link) end)
    label:SetCallback("OnEnter", function(button) ProfTooltip(button.frame, einstein, pname, einfo) end)
    label:SetCallback("OnLeave", function(button) addon.gui:SetStatusText(""); GameTooltip:Hide() end)
    label:SetHighlight(1,1,1,0.3)
    --grp:AddChild(label)
    --widget:AddChild(grp)
    widget:AddChild(label)
    local body = AceGUI:Create("SimpleGroup")
    body:SetLayout("List")
    body:SetFullWidth(true)
    for cname,dbc in cpairs(DB.chars) do
      local pinfo = dbc[pname]
      if (pinfo and cname ~= einstein) then
        if addon:isHidden(cname,pname) then hidone = true
	else
          local label = coloredcname(cname,settings.colorwinnames) ..
                  (cname == einstein and "" or " ("..pinfo.rank.." / "..pinfo.rankmax..")")
          body:AddChild(ProfIcon(cname,pname,pinfo,label,charicon(cname)))
	end
      end
    end
    scroller:AddChild(body)
  else -- grouped by character
    local dbc = DB.chars[cname]
    local label = AceGUI:Create("Label")
    label:SetFullWidth(true)
    label:SetFontObject(headerfont)
    if cname == einstein then
      label:SetText(einstein.."\n")
    else
      label:SetText(format(L["%s's Professions"],cname).."\n")
    end
    widget:AddChild(label)
    if cname == charName and (not dbc.data or not dbc.data.scanned) then
      widget:AddChild(MakeButton(L["Scan My Professions"], function () addon:ScanProfessions(); end))
      return
    end
    --[[
    local altcheck = AceGUI:Create("CheckBox")
    altcheck:SetValue(dbc.data.alt == true)
    altcheck:SetType("checkbox")
    altcheck:SetDescription(L["Is an alt"])
    altcheck:SetCallback("OnValueChanged", function (val) dbc.data.alt = val end)
    widget:AddChild(altcheck)]]
    for i=1,2 do
      local label = AceGUI:Create("Label")
      label:SetText(i==1 and L["Primary"]..":\n" or L["Secondary"]..":\n")
      label:SetFontObject(bodyfont)
      scroller:AddChild(label)
      local body = AceGUI:Create("SimpleGroup")
      body:SetLayout("Flow")
      body:SetFullWidth(true)
      --body:SetAutoAdjustHeight(true)
      for pname in pairs((i==1 and primaryProf) or (i==2 and secondaryProf)) do
        if (dbc[pname]) then
	 if addon:isHidden(cname,pname) then hidone = true
	 else
	  local pinfo = dbc[pname]
          body:AddChild(ProfIcon(cname,pname,pinfo))
	 end
	end
      end
      scroller:AddChild(body)
    end
  end
    widget:AddChild(scroller)
    if hidone then
      widget:AddChild(MakeButton(L["Unhide Entries"], function () addon:unHide(); end))
    end
    addon:FixStrata()
end
----------------------------------------------------------------------------------
-- AceGUI hacks --

-- hack-around for the fact AceGUI:Frame is too stupid to resize its title area to fit the text
function addon:fixTitle() 
  local tit = nil
  for _,v in pairs({ addon.gui.frame:GetRegions() }) do 
     local w = v:GetWidth()
     if w > 90 and w < 110 then 
        v:SetWidth(200) 
	tit = v
	break;
     end 
  end
 if false then 
  -- adjust the drag handle - this part should work but doesnt
  for _,v in pairs({ addon.gui.frame:GetChildren() }) do 
     local  w = v:GetWidth()
     local  h = v:GetHeight()
     if w > 95 and w < 105 and h > 35 and h < 45 then 
        v:SetAllPoints(tit) 
        v:SetWidth(400) 
     end 
  end
 end
end 

-- hack-around for the fact AceGUI doesnt allow frame locking
function addon:lockWidget(widget) 
  widget.lockinfo = {}
  for _,v in pairs({ widget.frame:GetChildren() }) do 
     local md = v:GetScript("OnMouseDown")
     local mu = v:GetScript("OnMouseUp")
     if md and mu then
       table.insert(widget.lockinfo,{frame=v,OnMouseDown=md,OnMouseUp=mu})
       v:SetScript("OnMouseDown",function()end)
       v:SetScript("OnMouseUp",function()end)
     end
  end
end
function addon:unlockWidget(widget) 
  if widget.lockinfo then
    for _,li in pairs(widget.lockinfo) do 
      li.frame:SetScript("OnMouseDown",li.OnMouseDown)
      li.frame:SetScript("OnMouseUp",li.OnMouseUp)
    end
    widget.lockinfo = nil
  end
end

-- hack to hook the escape key for closing the window
function addon:setEscapeHandler(widget, fn)
  widget.origOnKeyDown = widget.frame:GetScript("OnKeyDown")
  widget.frame:SetScript("OnKeyDown", function(self,key) 
        if key == "ESCAPE" then 
	   fn()
	elseif widget.origOnKeyDown then
	   widget.origOnKeyDown(self,key)
	end 
     end)
  widget.frame:EnableKeyboard(true)
  widget.frame:SetPropagateKeyboardInput(true)
end
function addon:clearEscapeHandler(widget)
  widget.frame:SetScript("OnKeyDown", widget.origOnKeyDown)
  widget.frame:EnableKeyboard(false)
  widget.frame:SetPropagateKeyboardInput(false)
end
-- allow custom layout of children
function addon:customizeLayout(widget, fn, destructor)
  widget.origLayoutFinished = widget.LayoutFinished
  widget.customizationDestructor = destructor
  widget.LayoutFinished = function () if widget.origLayoutFinished then widget.origLayoutFinished() end ; fn(); end
end
function addon:decustomizeLayout(widget)
  if widget.LayoutFinished then
    widget.LayoutFinished = widget.origLayoutFinished
    widget.origLayoutFinished = nil
    if widget.customizationDestructor then
       widget.customizationDestructor()
       widget.customizationDestructor = nil
    end
  end
end
----------------------------------------------------------------------------------
function addon:MakeHeaderButton(img, imgH, clickfn)
  local button = AceGUI:Create("InteractiveLabel")

  button:SetImage(img)
  button:SetHighlight(imgH)
  button:SetImageSize(32,32)
  button:SetWidth(32)
  button:SetHeight(32)

  button:SetCallback("OnClick", clickfn)
  --button.frame:SetFrameStrata("MEDIUM")
  button.frame:SetParent(addon.gui.frame)
  button.frame:SetFrameLevel(1000)
  button.frame:Show()

  return button
end

local icon_close = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up"
local icon_closeH = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight"
local icon_unlocked  = "Interface\\AddOns\\ProfessionsVault\\images\\LockButton-Unlocked"
local icon_locked  =   "Interface\\AddOns\\ProfessionsVault\\images\\LockButton-Locked"
function addon:ToggleLock(button)
  if settings.locked then
    debug("frame unlocked");
    settings.locked = false
    addon:unlockWidget(addon.gui)
    button:SetImage(icon_unlocked)
    button:SetHighlight(icon_closeH)
  else
    debug("frame locked");
    settings.locked = true
    addon:lockWidget(addon.gui)
    button:SetImage(icon_locked)
    button:SetHighlight(icon_closeH)
  end
end

function addon:CreateWindow()
  if addon.gui then
    return
  end
  addon:ScanSecondary()
  local f = AceGUI:Create("Frame")
  f.acegui_strata = f.frame:GetFrameStrata()
  f.frame:SetFrameStrata("MEDIUM")
  f.frame:Raise()
  f.content:SetFrameStrata("MEDIUM")
  f.content:Raise()
  addon.gui = f
  f:SetTitle(L["ProfessionsVault"].." "..ProfessionsVault.version)
  addon:fixTitle()
  f:SetCallback("OnClose", OnClose)
  f:SetLayout("Flow")
  f.frame:SetClampedToScreen(true)
  settings.pos = settings.pos or {}
  f:SetStatusTable(settings.pos)
  f:SetAutoAdjustHeight(true)

  --f:AddChild(MakeButton(L["Profession Pane"], function () ToggleSpellBook(BOOKTYPE_PROFESSION); end)) 
  local grp = AceGUI:Create("Dropdown")
  grp:SetMultiselect(false)
  grp:SetLabel(L["Group By"])
  grp:SetWidth(6*math.max(string.len(L["Character"]),string.len(L["Profession"]))+50)
  grp:SetList({
    [0] = L["Character"],
    [1] = L["Profession"],
  })
  grp:SetValue((settings.grpbyprof and 1) or 0)
  grp:SetCallback("OnValueChanged", function(w,evt,key) 
     settings.grpbyprof = (tostring(key) == "1"); 
     debug("settings.grpbyprof = "..key.." => "..((settings.grpbyprof and "true") or "false"))
     if settings.treepath then
       local a, b = unpack(settings.treepath)
       if a and b then
         settings.treepath = { b, a }
       else
         settings.treepath = nil
       end
     end
     addon:RefreshWindow() 
  end)
  f:AddChild(grp)
  f:AddChild(MakeButton(L["Scan My Professions"], function () addon:ScanProfessions(); end))
  f:AddChild(MakeButton(L["Config"], function () addon:Config(); end))

  local closeButton = addon:MakeHeaderButton(icon_close, icon_closeH,
                          function() addon:ToggleWindow() end)
  --f:AddChild(closeButton)
  local lockButton = addon:MakeHeaderButton(icon_unlocked, icon_closeH,
                          function(self) addon:ToggleLock(self) end)
  --f:AddChild(lockButton)
  addon:customizeLayout(f, function() 
     closeButton.frame:ClearAllPoints(); 
     closeButton:SetPoint("TOPRIGHT",f.frame,-5,-5)
     lockButton.frame:ClearAllPoints(); 
     lockButton:SetPoint("TOPRIGHT",closeButton.frame,"TOPLEFT",8,0)
  end, function() AceGUI:Release(closeButton); AceGUI:Release(lockButton) end)

  if settings.locked then
    settings.locked = false
    addon:ToggleLock(lockButton)
  end

  addon:setEscapeHandler(f, function() addon:ToggleWindow() end)

  local treedata = {}
  local expandicon = allexpandplus
  if settings.treestatus and settings.treestatus.groups then
    if settings.treestatus.groups[allexpand] then expandicon = allexpandminus end
  end
  table.insert(treedata, { value = allexpand, text = "\124cff"..charcolor("system")..ALL.."\124r",
                           visible = true, disabled = false, children = nil,
			   icon = expandicon })
 if settings.grpbyprof then -- group by profession
  for _,pname in ipairs(allProfSorted) do
   if not addon:isHidden(nil,pname) and allProf[pname].spellid ~= PID_SMELT then
    local pt = { value = pname, text = pname, visible = true, disabled = false,
                 icon = allProf[pname].icon,
                 children = {} }
    for cname,dbc in cpairs(DB.chars) do
      local pinfo = dbc[pname]
      if (cname ~= einstein and pinfo and not addon:isHidden(cname,pname)) then
        local img = charicon(cname)
	local coords
	if img and string.find(img,"BattlefieldFrame") then
	  coords = { 0.2,0.8,0.2,0.8 }
	end
        table.insert(pt.children, { value = cname, 
	         text = coloredcname(cname,settings.colorwinnames) .. 
		 (cname == einstein and "" or " ("..pinfo.rank.." / "..pinfo.rankmax..")"), 
	         visible = true, disabled = false,
                 icon = img, iconCoords = coords, children = nil })
      end
    end
    table.insert(treedata,pt)
   end
  end
 else -- group by character
  for cname,dbc in cpairs(DB.chars) do
    local img = charicon(cname)
    local coords
    if img and string.find(img,"BattlefieldFrame") then
       coords = { 0.2,0.8,0.2,0.8 }
    end
    local ct = { value = cname, text = coloredcname(cname,settings.colorwinnames), visible = true, disabled = false,
                 icon = img, iconCoords = coords, children = {} }
    for _,pname in ipairs(allProfSorted) do
      if (dbc[pname] and not addon:isHidden(cname,pname)) then
        local pinfo = dbc[pname]
        table.insert(ct.children, { value = pname, icon = allProf[pname].icon, visible = true,
                                      text = pname..
				      (cname == einstein and " ("..einstein..")" or
				      " ("..pinfo.rank.." / "..pinfo.rankmax..")") })
      end
    end
    if #ct.children > 0 or cname == charName then 
      table.insert(treedata, ct)
    end
  end
 end
  if false and settings.debug and myprint then
    myprint(treedata)
  end

  local tree = AceGUI:Create("TreeGroup")
  f:AddChild(tree)
  tree:SetAutoAdjustHeight(false)
  tree:SetFullWidth(true)
  tree:SetFullHeight(true)
  addon.tree = tree
  tree:SetTree(treedata)
  tree:SetCallback("OnGroupSelected", OnSelect)
  tree:SetCallback("OnClick", function (widget, event, path,...)
        local cname, pname = parsePath(path)
  	if activateontree then
	  if not cname then 
	    cname = einstein
	  end
	  if cname == allexpand or pname == allexpand then
	    pname = nil
	  end
  	  addon:ActivateLink(cname,pname,pname and DB.chars[cname][pname] and DB.chars[cname][pname].link)
  	end  
  end)
  tree:SetCallback("OnButtonEnter", function(button,event,path,frame) 
                   if path == allexpand then return end
                   local cname, pname = parsePath(path)
		   addon.gui:SetStatusText(cname)
		   if pname and cname then
                     ProfTooltip(frame, cname, pname, DB.chars[cname][pname]) 
		   elseif pname and settings.tooltips then -- group by prof header
                     ProfTooltip(frame, einstein, pname, DB.chars[einstein][pname]) 
		   elseif cname and settings.tooltips then -- group by char header
                     GameTooltip:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
                     GameTooltip:SetText(cname);
                     local text =  chardatastr(cname)
                     if #text then
                       GameTooltip:AddLine(text)
                     end
                     GameTooltip:AddLine("|cffff8040"..L["Right Click"].."|r "..L["for menu"])
                     GameTooltip:Show()
		   end
		   end)
  tree:SetCallback("OnButtonLeave", function() GameTooltip:Hide() end)
  tree:EnableButtonTooltips(false)

  settings.treestatus = settings.treestatus or {}
  tree:SetStatusTable(settings.treestatus)
  if settings.treepath then
    activateontree = false
    tree:SelectByPath(unpack(settings.treepath))
    activateontree = true
  end
  addon:FixStrata()
end

function addon:FixStrata(widget,lvl)
  widget = widget or addon.gui
  lvl = lvl or widget.frame:GetFrameLevel()
  if widget.frame then 
    widget.frame:SetFrameLevel(lvl)
  end
  if widget.content then 
    widget.content:SetFrameLevel(lvl+1)
  end
  if widget.children then
    for _,child in ipairs(widget.children) do
      addon:FixStrata(child, lvl+2)
    end
  end
end

function addon:ToggleWindow()
  debug("ToggleWindow")

  if addon.gui then
    addon.gui:Hide()
  else
    addon:CreateWindow()
  end
end

-- refresh the contents of the window, optionally performing an action while hidden
function addon:RefreshWindow(actionfunc)
  local show
  if addon.gui then
    addon.gui:Hide()
    show = true
  end

  if actionfunc then
    actionfunc()
  end

  if show then
    addon:CreateWindow()
  end
end

function addon:Reset() 
  if addon.gui then
    addon:ToggleWindow()
  end
  StaticPopup_Show("PROFESSIONSVAULT_RESET")
end

local function ResetConfirmed()
  addon.db:ResetDB() -- triggers RefreshConfig
  addon:AddEinstein()
  chatMsg(L["Reset complete."]); 
end

StaticPopupDialogs["PROFESSIONSVAULT_RESET"] = {
  text = L["Are you sure you want to reset the ProfessionsVault database and wipe all data?"],
  button1 = OKAY,
  button2 = CANCEL,
  OnAccept = ResetConfirmed,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  enterClicksFirstButton = false,
  showAlert = true,
}

function addon:Scan() 
  StaticPopup_Show("PROFESSIONSVAULT_SCAN")
end

StaticPopupDialogs["PROFESSIONSVAULT_SCAN"] = {
  text = L["Would you like to scan your professions into ProfessionsVault?"],
  button1 = OKAY,
  button2 = CANCEL,
  OnAccept = function () addon:ScanProfessions() end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  enterClicksFirstButton = false, -- doesnt trigger HW event >.<
}

function addon:Config() 
  if optionsFrame then
    if ( InterfaceOptionsFrame:IsShown() ) then
      InterfaceOptionsFrame:Hide();
    else
      InterfaceOptionsFrame_OpenToCategory(optionsFrame)
    end
  end
end

function addon:unHide()
  if unhideFrame then
      if ( InterfaceOptionsFrame:IsShown() ) then
        InterfaceOptionsFrame:Hide();
      end
      InterfaceOptionsFrame_OpenToCategory(unhideFrame)
  end
end
----------------------------------------------------------------------------
-- Testing code
----------------------------------------------------------------------------
function addon:spellLink(pname)
  local spellid = pname and allProf[pname] and allProf[pname].spellid
  if not spellid then return "" 
  else
    return "\124cff71d5ff\124Hspell:"..spellid.."\124h["..pname.."]\124h\124r"
  end
end
function addon:fakeLink(profName, guid, spellid, rank, rankmax, patlen) 
  spellid = spellid or allProf[profName].spellid
  patlen = patlen or allProf[profName].patlen
  guid = guid or UnitGUID("player")
  rankmax = rankmax or gamerankmax
  rank = rank or rankmax
  guid = string.gsub(guid,"0x","")
  local known = string.rep("/",patlen)
  local link = 
         "\124cffffd000"..
         "\124Htrade:"..spellid..":"..rank..":"..rankmax..":"..
          guid..":"..known.."\124h["..profName.."]\124h"..
         "\124r"
  --print(patlen..": "..link)
  return link
end
function addon:fakeLinkScan(profName, guid, spellid, rank, rankmax) 
  spellid = spellid or allProf[profName].spellid
  CastSpellByName("Cooking")
  CloseTradeSkill()
  for i=0,200 do
    local link = addon:fakeLink(profName, guid, spellid, rank, rankmax, i)
    SetItemRef(cleanlink(link),link,"LeftButton",ChatFrame1)
    if TradeSkillFrame:IsVisible() and GetTradeSkillLine() and IsTradeSkillLinked() then
      print("Success at "..spellid.." "..i.." "..GetSpellInfo(spellid).." "..link)
      --printlink(link)
      break
    end
  end
end

function PV_linkscan(min,max) 
  local known = {}
  for k,v in pairs(allProf) do
      known[v.spellid] = k
  end
  for i=min,max do
    if known[i] and false then
      print("Skipping "..i.." "..known[i])
    else
      if i%100 == 0 then
        print("testing "..i)
      end
      addon:fakeLinkScan("linkscan",i)
    end
  end
  print("Scan complete: "..min..".."..max)
end

function addon:CleanDatabase() -- remove links that are dead due to a patch
  local clientversion, clientbuild = GetBuildInfo()
  clientbuild = tonumber(clientbuild) or 0
  local DB = self.db.realm
  local oldclientbuild = DB.clientbuild or 13329 -- for old versions
  DB.clientversion = clientversion
  DB.clientbuild = clientbuild
  --print(oldclientbuild.." "..clientbuild)
  local removed = 0
  for pname,profinfo in pairs(allProf) do
    local patlen = profinfo.patlen
    for cname,dbc in pairs(DB.chars) do
      local pinfo = dbc[pname]
      if (pinfo and cname ~= einstein) then
        local link = pinfo.link
	local ocb = pinfo.clientbuild or -- assume 4.1 (when per-link vers were added) if we don't know better
	    (oldclientbuild < 14007 and oldclientbuild or 14007)
	local oldclientbuild = ocb
        local databits = link and addon:extract_bits(link)
        --print(cname.." "..pname.." "..#databits.." "..patlen)
        if (databits and #databits ~= patlen) or -- patlen increase

	  -- 4.0.6 bits rearranged without patlen change
	  (oldclientbuild <= 13329 and clientbuild > 13329 and 
            ((pname == GetSpellInfo(PID_COOK)) or 
             (pname == GetSpellInfo(PID_ALCH))) ) or

	  -- 4.1 bits rearranged without patlen change
	  (oldclientbuild <= 13623 and clientbuild > 13623 and 
             ( (pname == GetSpellInfo(PID_ALCH)) or
               (pname == GetSpellInfo(PID_ENG))) ) or 

	  -- 4.2: bits rearranged without patlen change
	  (oldclientbuild <= 14007 and clientbuild > 14007 and 
              (pname == GetSpellInfo(PID_COOK)) ) or

	  -- 4.3: bits rearranged without patlen change
	  (oldclientbuild <= 14545 and clientbuild >= 15005 and 
              (pname == GetSpellInfo(PID_INSC)) ) or

	  (pname == GetSpellInfo(PID_SMELT)) -- smelting db permanently deprecated

	  then
          dbc[pname] = nil
	  removed = removed + 1
          if (dbc.data.scanned) then dbc.data.scanned = false end
	end
      end
    end
  end
  if removed > 0 then
    chatMsg(removed.." "..L["Outdated profession links have been removed."])
  end
end

function addon:AddEinstein() -- a toon that knows all the patterns
  DB.chars[einstein] = {}
  local DBe = DB.chars[einstein]
  DBe.data = {}
  DBe.data.name = name
  --DBe.data.faction = UnitFactionGroup("player")
  --DBe.data.level = 1
  --DBe.data.class = UnitClass("player")
  DBe.data.scanned = true
  DBe.data.alt = false

  for _,pname in ipairs(allProfSorted) do
    if (allProf[pname].patlen > 1) then
      DBe[pname] = {
	rank = gamerankmax,
	rankmax = gamerankmax,
	-- not linkable with fake text, server bans it
	--link = addon:fakeLink(pname.." ("..einstein..")", nil, allProf[pname].spellid, 0, 0, allProf[pname].patlen)
	link = addon:fakeLink(pname, nil, nil, 0, 0, nil)
      }
    end
  end

end
----------------------------------------------------------------------------
-- Link manipulation
----------------------------------------------------------------------------
local function table_invert(t)
  local ret = {}
  for k,v in pairs(t) do
    if ret[v] then
      debug(format("Duplicate value %s in table_invert",v))
    end
    ret[v] = k
  end
  return ret
end

-- conjunctions used in transmute names that need to be normalized away
local xmute_conjunctions = {}
local xmute_token = strtrim(string.lower(L["Transmute"]))
if locale == "enUS" then 
  xmute_conjunctions = { " to " }
elseif locale == "deDE" then 
  xmute_conjunctions = { " zu ", " in " }
elseif locale == "esES" or locale == "esMX" then 
  xmute_conjunctions = { " a ", " en " }
elseif locale == "frFR" then 
  xmute_conjunctions = { " en ", " du ", " de la ", " de l'", " de l\226\128\153", " de ", " d'", " des " }
elseif locale == "ruRU" then 
  xmute_conjunctions = { " \208\178 " }
else 
  xmute_conjunctions = { }
end
local figurine_token = strtrim(string.lower(L["Figurine"]))

local function normalize(spellname) -- normalize minor differences in spellnames
  if not spellname then return nil end
  spellname = string.lower(spellname)
  if string.find(spellname, xmute_token) then -- Transmute spelling is a mess
    spellname = string.gsub(spellname, xmute_token, "") 
    for _,conj in ipairs(xmute_conjunctions) do
      spellname = string.gsub(spellname, conj, " ")
    end
    spellname = xmute_token.." "..spellname
  end
  spellname = string.gsub(spellname, "%p", " ") -- punctuation
  if locale == "frFR" then -- the item database translation to french is absolutely TERRIBLE
    -- damn abbreviations - lazy french translators should be dragged out and shot
    spellname = string.gsub(spellname, "enchantements?", "ench")
    spellname = string.gsub(spellname, "caract..ristiques", "caract")
    spellname = string.gsub(spellname, " caract ", " carac ")
    spellname = string.gsub(spellname, "sup..rieures?", "sup")
    spellname = string.gsub(spellname, "inf..rieures?", "inf")
    spellname = string.gsub(spellname, "intelligence", "intel")
    spellname = string.gsub(spellname, "restauration", "rest")
    spellname = string.gsub(spellname, "puissance", "puiss")
    spellname = string.gsub(spellname, "puissant", "puiss")
    spellname = string.gsub(spellname, "chanteante", "changeante")
    spellname = string.gsub(spellname, "(%w%w%w%w%w)s ", "%1 ") -- trailing s on long words
    -- and they cannot decide on conjunctions
    for _,conj in ipairs(xmute_conjunctions) do
      spellname = string.gsub(spellname, string.gsub(conj, "%p", " "), " ")
    end
    -- or accents
    spellname = string.gsub(spellname, "\197\147", "oe")
    spellname = string.gsub(spellname, "\195\169", "e")
    spellname = string.gsub(spellname, "\195\162", "a")
  elseif locale == "esES" or locale == "esMX" then
    spellname = string.gsub(spellname, " de ", " ") -- encantar arma (de) 2M
    spellname = string.gsub(spellname, " a la ", " ") -- 18291
    spellname = string.gsub(spellname, " de las ", " ") -- 21915
    spellname = string.gsub(spellname, " m..scara ", " marca ") -- item 66999 and friends
    spellname = string.gsub(spellname, "muerte", "muerto") -- item 13486 and friends
    spellname = string.gsub(spellname, "rpido grueso", "rpido pesado") -- item 15724 and friends
    spellname = string.gsub(spellname, "primigeni.(.+)primigeni.", "primigenio%1") -- item 22915 and friends
    spellname = string.gsub(spellname, "primigeni.", "primigenio") -- item 22915 and friends
  end
  spellname = string.gsub(spellname, figurine_token, " ") -- old-world figurines drop the token TODO: need more for ruRU
  spellname = string.gsub(spellname, "\194\160", " ") -- non-breaking space
  spellname = string.gsub(spellname, "%s+", " ") -- extra space
  spellname = strtrim(spellname) -- extra space
  --myprint(spellname)
  --if string.find(spellname, xmute_token) then   print(spellname); print(string.byte(spellname,1,#spellname)) end
  return spellname
end
function addon:normalize(s) return normalize(s) end

function addon:hash(str) -- a dumbed-down crc32
  str = tostring(str)
  local count = string.len(str)
  local val = tonumber(count)
  for i = 1,count do
    local byte = tonumber(string.byte(str,i))
    val = bit.bxor(bit.lshift(val,8), bit.lshift(bit.bxor(bit.rshift(val,24), byte),i%3))
  end
  return tonumber(val)
end

function addon:build_tables() 
  local start = GetTime()
  PV_code_to_bits = {}
  PV_bits_to_code = {}
  local bits = 0
  for charid=string.byte("A"),string.byte("Z") do
    PV_code_to_bits[string.char(charid)] = bits
    bits = bits + 1
  end
  for charid=string.byte("a"),string.byte("z") do
    PV_code_to_bits[string.char(charid)] = bits
    bits = bits + 1
  end
  for charid=string.byte("0"),string.byte("9") do
    PV_code_to_bits[string.char(charid)] = bits
    bits = bits + 1
  end
  PV_code_to_bits["+"] = bits
  bits = bits + 1
  PV_code_to_bits["/"] = bits
  bits = bits + 1
  assert(bits == 64)
  PV_bits_to_code = table_invert(PV_code_to_bits)

  addon.ttcache = addon.ttcache or {}
  addon.ttcachecnt = addon.ttcachecnt or 0

  --PV_Exceptions_StoI = table_invert(PV_Exceptions_ItoS)
  PV_Exceptions_StoI = {}
  new_ItoS = {}
  for itemid, spellid in pairs(PV_Exceptions_ItoS) do
    PV_Exceptions_StoI[spellid] = itemid
    if type(itemid) == "table" then
      for _,i in ipairs(itemid) do
        new_ItoS[i] = spellid
      end
    else
      new_ItoS[itemid] = spellid
    end
  end
  PV_Exceptions_ItoS = new_ItoS

  -- localize the pattern database
  do
  if PV_PatDB and not PV_PatDBL then
    local md = PV_Data_VersionInfo
    assert(md)
    local exp = { [0] = "Classic", [1] = "TBC", [2] = "WotLK", [3] = "Cata" }
    debug("Loading PV_PatDB v"..md.DBversion.."-"..md.DBrevision.." for client "..
            exp[md.clientexpansion].." "..
            md.clientversion.."-"..md.clientbuildmax)
    local clientexpansion = GetExpansionLevel()
    local clientversion, clientbuild = GetBuildInfo()
    clientbuild = tonumber(clientbuild) or 0
    if clientexpansion > md.clientexpansion or
       --clientversion ~= md.clientversion or  -- build number is primary
       clientbuild < tonumber(md.clientbuildmin) or clientbuild > tonumber(md.clientbuildmax) then
      local msg = L["WARNING: This version of ProfessionsVault was compiled for a different version of WoW (%s) than you are running (%s). Some features may be broken. Please download an update from %s"]
      msg = format(msg, format("%s %s-%d", exp[md.clientexpansion], md.clientversion, md.clientbuildmax),
                        format("%s %s-%d", exp[clientexpansion], clientversion, clientbuild),
                        addon_website)
      chatMsg(msg)
    end
    PV_PatDBL = {}
    for profname, pinfo in pairs(allProf) do
      local pid = pinfo.spellid
      if PV_PatDB[pid] then
        local parr = {}
	for spellid, bitidx in pairs(PV_PatDB[pid]) do
	  local spellname = GetSpellInfo(spellid)
	  spellname = normalize(spellname)
          if spellid == 0 then	  
	    parr[0] = bitidx -- metadata
	  elseif not spellname then
	    debug("ERROR: spellid not found: "..spellid)
	  else
	    local parridx
	    if PV_Exceptions_StoI[spellid] then
	      parridx = PV_Exceptions_StoI[spellid] 
	      if parr[parridx] then
	          chatMsg("ERROR: Duplicate exception: "..spellname.."  ("..spellid.."-"..GetLocale()..") Please report this bug!")
	      end
	    elseif usehashes then
	      parridx = addon:hash(spellname) 
	      if parr[parridx] then
	          chatMsg("ERROR: Duplicate spell or hash coll: "..spellid.." "..spellname.."-"..GetLocale().."  ("..parridx..") bit="..parr[parridx].." Please report this bug!")
	      end
	    else
	       parridx = spellname 
	       if parr[spellname] then
	          chatMsg("ERROR: Duplicate spellname: "..spellid.." "..spellname.."-"..GetLocale().."  bit="..parr[spellname].." Please report this bug!")
	       end
	    end
	    if type(parridx) == "table" then
	      for _,i in pairs(parridx) do -- crafted and recipe
	         parr[i] = bitidx
	      end
	    else
	      parr[parridx] = bitidx
	    end
	  end
	end -- for spellid
	PV_PatDBL[pid] = parr
      end
    end -- for prof
    PV_PatDB = nil
    end
  end

  debug(format("build_tables: %.3f s", GetTime()-start))
  collectgarbage("collect")
end 

function addon:extract_bits(link)
  if not link then return nil end
  local databits = string.match(link, "\124Htrade:%d+:%d+:%d+:%x+:([^\124]+)\124h")
  return databits
end

function addon:link_rank(link)
  if not link then return nil end
  local rank, rankmax = string.match(link, "\124Htrade:%d+:(%d+):(%d+):")
  rank = tonumber(rank)
  rankmax = tonumber(rankmax)
  return rank, rankmax
end

-- query a single bit in a trade link
function addon:link_bit(link, bitidx)
  local chunkid = math.floor(bitidx / 6)
  local chunkbit = bitidx % 6
  local databits = addon:extract_bits(link)
  if chunkid > #databits then -- may happen after a patch
    return false
  end
  local chunk = string.sub(databits, chunkid+1, chunkid+1)
  --print("chunk="..chunk)
  local bits = PV_code_to_bits[chunk]
  --print("bits="..bits)
  return bit.band(2^chunkbit, bits) > 0
end

-- count the number of bits set in a trade link (excludes dead bits)
function addon:link_bit_count(link)
  local databits = addon:extract_bits(link)
  if not databits then return 0 end
  local profid = tonumber(string.match(link,"\124Htrade:(%d+):"))
  local deadbits = profid and PV_PatDBL and PV_PatDBL[profid] and PV_PatDBL[profid][0].deadbitmask
  if deadbits and #deadbits ~= #databits then deadbits = nil end
  --print(databits) ; print(deadbits)
  local chunkcnt = #databits
  local result = 0
  for chunkid=0,chunkcnt-1 do
    local chunk = string.sub(databits, chunkid+1, chunkid+1)
    local bits = PV_code_to_bits[chunk]
    if deadbits then
      local deadmask = string.sub(deadbits, chunkid+1, chunkid+1)
      local deadchunk = PV_code_to_bits[deadmask]
      bits = bit.band(bits, bit.bnot(deadchunk))
    end
    --if bits > 0 then print(format("bits=%x",bits)) end
    while bits > 0 do
      result = result + bit.band(bits,1)
      bits = bit.rshift(bits,1)
    end
  end
  return result
end

-- create a trade link with one bit set
function addon:singlebit_link(profName, bitidx, rank, rankmax, guid)
  local spellid = allProf[profName].spellid
  local patlen = allProf[profName].patlen
  guid = guid or UnitGUID("player")
  guid = string.gsub(guid,"0x","")
  rankmax = rankmax or gamerankmax
  rank = rank or rankmax
  local chunkid = math.floor(bitidx / 6)
  local chunkbit = bitidx % 6

  local bits = string.rep(PV_bits_to_code[0],chunkid) ..
               PV_bits_to_code[2^chunkbit] ..
               string.rep(PV_bits_to_code[0],patlen-chunkid-1)

  local link = "\124Htrade:"..spellid..":"..rank..":"..rankmax..":"..
          guid..":"..bits.."\124h["..profName.."]\124h"

  return link
end

-- converts an array of { bitidx1, bitidx2 } into a link
function addon:bitlist_to_link(profName, bitlist, rank, rankmax, guid)
  local spellid = allProf[profName].spellid
  local patlen = allProf[profName].patlen
  local ibitlist = table_invert(bitlist)
  guid = guid or UnitGUID("player")
  guid = string.gsub(guid,"0x","")
  rankmax = rankmax or gamerankmax
  rank = rank or rankmax

  local bits = ""
  for chunkid = 0, patlen-1 do
    local chunk = 0
    for chunkbit = 5,0,-1 do
      local bitidx = chunkid*6 + chunkbit
      chunk = bit.lshift(chunk, 1)
      if ibitlist[bitidx] then
        chunk = chunk + 1
      end
    end
    bits = bits..PV_bits_to_code[chunk]
  end

  local link = "\124cffffd000\124Htrade:"..spellid..":"..rank..":"..rankmax..":"..
          guid..":"..bits.."\124h["..profName.."]\124h\124r"

  return link
end

-- normalize the profession clauses of a trade link 
function addon:normalize_link(link)
   if not link then return nil end
   local oldlink = link
   local oldspell, oldtag = string.match(link,"\124Htrade:(%d+):.*\124h(.*)\124h")
   --print(link.." "..(oldspell or "NIL"))
   local oldprof = GetSpellInfo(oldspell)
   local profname = oldprof
   if not allProf[profname] then
     for k,v in pairs(allProf) do
       for _,a in ipairs(v.aliases) do
         if a == oldprof then
           profname = k
	   break
         end
       end
     end
   end
   if not allProf[profname] then
     chatMsg("ERROR: Unrecognized profession "..oldprof.." ("..oldspell.."-"..GetLocale()..") in trade link "..oldlink..". Please report this bug!")
     return oldlink
   end
   local newspell = allProf[profname].spellid
   link = string.gsub(link, "\124Htrade:"..oldspell..":", "\124Htrade:"..newspell..":")
   link = string.gsub(link, "\124h(.*)\124h", "\124h["..profname.."]\124h")
   if link ~= oldlink then
     debug("normalize_link("..oldlink..") => "..link)
   end
   return link, profname, newspell
end


function addon:BuildGuildTradeLink()
  local pname, rank, rankmax = GetTradeSkillLine()
  local linked, cname = IsTradeSkillLinked()
  if not linked or not pname or not cname then return nil end
  local profid = allProf[pname].spellid
  local guid = guid_expand(DB.guid_cache[cname])
  if not guid or not profid then return nil end
  

  -- expand all window settings
  SetTradeSkillInvSlotFilter(0);
  SetTradeSkillSubClassFilter(0);
  SetTradeSkillItemNameFilter("");
  TradeSkillOnlyShowMakeable(false);
  TradeSkillOnlyShowSkillUps(false);
  ExpandTradeSkillSubClass(0);

  local bitlist = {}
  for idx = 1,GetNumTradeSkills() do
    local skillname, skilltype = GetTradeSkillInfo(idx)
    if skillname and skilltype ~= header then
      local link = GetTradeSkillRecipeLink(idx)
      local spellid = link and string.match(link,"\124Henchant:(%d+)\124")
      spellid = tonumber(spellid)
      if spellid then
          local spellname = normalize(skillname)
          local arridx
          if PV_Exceptions_StoI[spellid] then
            arridx = PV_Exceptions_StoI[spellid]
            if type(arridx) == "table" then arridx = arridx[1] end
          else
            arridx = (usehashes and addon:hash(spellname)) or spellname
          end
          local bit = spellname and PV_PatDBL[profid] and PV_PatDBL[profid][arridx]
          if not bit then
            chatMsg(format(L["ERROR: Missing entry in pattern database: %s Please report this bug!"],
              format("%d %s: %s",spellid,pname,skillname.."-"..GetLocale())))
          else
            debug(spellid .. " " .. link .. ": ".. bit)
            table.insert(bitlist, bit)
          end
      end
    end
  end
  
  return addon:bitlist_to_link(pname, bitlist, rank, rankmax, guid) 
end

function addon:populate_database(profName)
  if not profName then
    addon.db.global.patDB = nil
    print("patDB wiped")
    return
  end
  CastSpellByName("Cooking")
  -- expand all window settings
  SetTradeSkillInvSlotFilter(0);
  SetTradeSkillSubClassFilter(0);
  SetTradeSkillItemNameFilter("");
  TradeSkillOnlyShowMakeable(false);
  TradeSkillOnlyShowSkillUps(false);
  CloseTradeSkill()

  local bitlen = allProf[profName].patlen*6
  local profid = allProf[profName].spellid
  local patcnt = 0
  local errcnt = 0
  local changecnt = 0
  local patDB = {}
  patDB[0] = {}
  local deadbits = {}
  local header = patDB[0]
  local checkstr = profid..","..bitlen
  header.name = profName
  header.bitlen = bitlen
  header.scandate = date()
  header.version, header.build = GetBuildInfo()
  print("Scanning "..bitlen.." "..profName.." bits")
  for bitidx = 0,bitlen-1 do
    local link = addon:singlebit_link(profName, bitidx)
    --printlink(link)
    SetItemRef(cleanlink(link),link,"LeftButton",ChatFrame1)
    if GetTradeSkillLine() and IsTradeSkillLinked() then
      local num = GetNumTradeSkills()
      local idx = GetFirstTradeSkill()
      local skillName, skillType = GetTradeSkillInfo(idx)
      if (num == 0 or not skillName or not skillType or skillType == "header") then
        print(link.." bit "..bitidx..": empty bit")
	checkstr = checkstr..",empty"
	table.insert(deadbits, bitidx)
      else
        local itemlink = GetTradeSkillItemLink(idx)
        local recipelink = GetTradeSkillRecipeLink(idx)

        local spellid = string.match(recipelink, "\124Henchant:(%d+)\124h")
        print(link.." bit "..bitidx..": "..skillName.." "..spellid.." "..itemlink.." "..recipelink)
        patcnt = patcnt + 1
        spellid = tonumber(spellid)
	checkstr = checkstr..","..spellid
        if patDB[spellid] and patDB[spellid] ~= bitidx then
          print("ERROR: duplicate bit found at bit "..bitidx)
          errcnt = errcnt + 1 
        else
          patDB[spellid] = bitidx
	  local spellname = normalize(skillName)
	  local arridx 
	  if PV_Exceptions_StoI[spellid] then
	    arridx = PV_Exceptions_StoI[spellid]
	    if type(arridx) == "table" then arridx = arridx[1] end
	  else
	    arridx = (usehashes and addon:hash(spellname)) or spellname
	  end
	  local oldbit = spellname and PV_PatDBL[profid] and PV_PatDBL[profid][arridx]
	  if oldbit ~= bitidx then
	    print("oldbit = "..(oldbit or "nil"))
	    changecnt = changecnt + 1
	  end
        end
      end
    end
  end
  local deadlink = addon:bitlist_to_link(profName,deadbits)
  local deadbitmask = addon:extract_bits(deadlink)
  print("Dead bit link: "..deadlink)
  header["deadbitmask"] = deadbitmask
  header["patcnt"] = patcnt
  header["checksum"] = addon:hash(checkstr)
  local oldchecksum = PV_PatDBL[profid][0].checksum
  print("Scanned "..bitlen.." "..profName.." bits, saved "..patcnt.." patterns, "..errcnt.." errors.")
  print("Detected "..changecnt.." changes. "..(oldchecksum and "Old Checksum = "..oldchecksum or "")..
        " New Checksum = "..header["checksum"]..(oldchecksum == header["checksum"] and " (match)" or "(mismatch)"))
  addon.db.global.patDB = addon.db.global.patDB or {}  
  addon.db.global.patDB[profid] = patDB
end

addon.scantt = CreateFrame("GameTooltip", "ProfessionsVault_Tooltip", UIParent, "GameTooltipTemplate")
addon.scantt:SetOwner(UIParent, "ANCHOR_NONE");
addon.scantex = addon.scantt:CreateTexture("scantex")

function addon:recipeClass()
  if not addon._recipeClass then
    addon._recipeClass = select(6,GetItemInfo(43017))
  end
  return addon._recipeClass 
end

function addon:isRecipe(itemid)
  local class = select(6,GetItemInfo(itemid))
  return class == addon:recipeClass()
end

function addon:isCraftedItem(itemid)
  if not addon._scrollClass then
    addon._scrollClass, addon._scrollSubClass = select(6,GetItemInfo(38872))
  end
  if not addon._glyphClass then
    addon._glyphClass = select(6,GetItemInfo(45772))
  end
  if not addon._gemClass then
    addon._gemClass = select(6,GetItemInfo(23077))
  end
  local name,link,quality,ilvl,_, class, subclass = GetItemInfo(itemid)
  if class == addon._glyphClass then
     return "glyph"
  elseif class == addon._scrollClass and subclass == addon._scrollSubClass and
         string.find(name, L["Scroll of"]) then
     return "scroll"
  elseif class == addon._gemClass then
     local ignorewords 
     if locale == "enUS" then     ignorewords = { "Perfect", "Ornate" }
     elseif locale == "deDE" then ignorewords = { "Perfekter", "Schmuck" }
     elseif locale == "esES" then ignorewords = { "perfect", "ornamentad" } -- ending intentionally omitted
     elseif locale == "frFR" then ignorewords = { "parfait", "orné" }
     elseif locale == "ruRU" then ignorewords = { 
       "\208\161\208\190\208\178\208\181\209\128\209\136\208\181\208\189\208\189\209\139\208\185", -- perfect
       "\208\161\208\190\208\178\208\181\209\128\209\136\208\181\208\189\208\189\208\176\209\143", -- perfect (alt spelling)
       "\208\184\208\183\209\139\209\129\208\186\208\176\208\189\208\189\209\139\208\185" -- ornate
     }
     end
     local jcdb = addon.db.global.JCDB
     name = string.lower(name)
     local guessuncut = string.match(name, "^[^%s]+%s(.+)$")
     if jcdb[guessuncut] then return "gem" end
     for uncut,_ in pairs(jcdb) do
       if string.find(name, uncut) and 
          (#name > #uncut or 
	   (ilvl == 80 and quality == 4) or -- WoLK epic raws created by alc
	   (ilvl == 85 and quality == 3))   -- Cata rare raws created by alc
	 then
	 if ignorewords then
	   for _,iw in pairs(ignorewords) do
	     if string.find(name, string.lower(iw)) then return nil end
	   end
	 end
         return "gem"
       end
     end
  end
  return nil
end

function addon:ScanJC()
  local jcdb = {}

  local pname = GetSpellInfo(25229)
  local link = DB.chars[einstein][pname].link
  local gemClass = select(6,GetItemInfo(23077))
  SetItemRef(cleanlink(link),link,"LeftButton",ChatFrame1)
  jcdb.locale = locale

  -- expand all window settings
  SetTradeSkillInvSlotFilter(0);
  SetTradeSkillSubClassFilter(0);
  SetTradeSkillItemNameFilter("");
  TradeSkillOnlyShowMakeable(false);
  TradeSkillOnlyShowSkillUps(false);
  ExpandTradeSkillSubClass(0);

  for idx = 1,GetNumTradeSkills() do
    local skillname, skilltype = GetTradeSkillInfo(idx)
    if skillname and skilltype ~= header and GetTradeSkillNumReagents(idx) == 1 then
      local link = GetTradeSkillRecipeLink(idx)
      local reagentlink = GetTradeSkillReagentItemLink(idx, 1)
      if reagentlink then
        local itemid = string.match(reagentlink, "\124Hitem:(%d+):")
        --local itemname = string.match(reagentlink, "\124h%[(.+)%]\124h")
        local itemname,_,_,_,_, class, subclass = GetItemInfo(itemid)
        if itemid and itemname and class == gemClass then
          jcdb[string.lower(itemname)] = tonumber(itemid)
        end
      end
    end
  end
  local count = 0
  for k,v in pairs(jcdb) do
    chatMsg(k.." "..v)
    count = count + 1
  end
  chatMsg("ScanJC detected "..count.." raw gems")
  if count < 57 then --cache failure
    chatMsg("Please run again!")
    addon.db.global.JCDB = nil
  else
    addon.db.global.JCDB = jcdb
  end
end

function addon:RefreshTooltips() -- reset the tooltip state
  debug("RefreshTooltips")
  addon.ttcache = {} -- clear tooltip cache
  addon.ttcachecnt = 0
  GameTooltip:Hide()
  ItemRefTooltip:Hide()
  if AtlasLootTooltip then AtlasLootTooltip:Hide() end
  addon:SetAuctionColors()
end

-- -----------------------------------------------------------------------------
local function frameupdate(frame)
  debug("Container frameupdate")
  local bagid = frame:GetID();
  if (settings.bagcolor and bagid >= 0 and bagid <= NUM_BAG_SLOTS) or
     (settings.bankcolor and (bagid == -1 or bagid > NUM_BAG_SLOTS)) then
    local name = frame:GetName();
    addon:BagUpdate(bagid, name)
  end
end
hooksecurefunc("ContainerFrame_Update", frameupdate)
hooksecurefunc("ContainerFrame_UpdateCooldowns", frameupdate)

hooksecurefunc("BankFrameItemButton_Update",
function (button)
  --debug("BankFrameItemButton_Update")
  if not button.isBag then
    local texture = _G[button:GetName().."IconTexture"];
    local itemid = GetContainerItemID(BANK_CONTAINER, button:GetID())
    itemid = settings.bankcolor and itemid
    addon:SlotColor(itemid, texture)
  end 
end)

function addon:BagUpdate(bagid, framename)
  local numslots = GetContainerNumSlots(bagid)
  for slot=1,numslots do
    local itemid = GetContainerItemID(bagid, slot)
    local textureid
    if addon.onebagaddon then -- OneBag3 reverts the texture IDs and uses them
      textureid = slot
    else -- default UI inverts textureids
      textureid = (numslots-slot+1)
    end
    local texture = _G[framename.."Item"..textureid.."IconTexture"]
    addon:SlotColor(itemid, texture)
  end
end

function addon:GuildBankFrame_Update(clear)
  if (settings.bankcolor or clear) and GuildBankFrame then
    local tab = GetCurrentGuildBankTab();
    for slot=1, MAX_GUILDBANK_SLOTS_PER_TAB do
       local itemlink = GetGuildBankItemLink(tab, slot)
       local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
       itemid = itemid and tonumber(itemid)
       local index = mod(slot, NUM_SLOTS_PER_GUILDBANK_GROUP);
       if ( index == 0 ) then
          index = NUM_SLOTS_PER_GUILDBANK_GROUP;
       end
       local column = ceil((slot-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP);
       local texture = _G["GuildBankColumn"..column.."Button"..index.."IconTexture"];
       itemid = (not clear) and itemid
       addon:SlotColor(itemid, texture, true)
    end
  end
end

hooksecurefunc("InboxFrame_Update",
function (clear)
  debug("InboxFrame_Update")
  if (settings.mailcolor or clear) and InboxFrame then
    for i = 1, INBOXITEMS_TO_DISPLAY do
      local itemid = nil
      local button = _G["MailItem"..i.."Button"]
      local texture = _G[button:GetName().."Icon"]
      if button and button:IsVisible() and button.itemCount == 1 then
        local itemlink = GetInboxItemLink(button.index, 1)
        itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
        itemid = itemid and tonumber(itemid)
        --print(itemlink.." "..itemid)
      end
      itemid = (not clear) and itemid
      local reqlvl, class
      if itemid then reqlvl, class = (itemid and select(5,GetItemInfo(itemid))) end
      --if itemid then print(itemid.." "..(reqlvl or "nil").." "..(class or "nil")) end
      if reqlvl and class ~= addon:recipeClass() and reqlvl > UnitLevel("player") then
        texture:SetVertexColor(1,0,0)
      else
        addon:SlotColor(itemid, texture, true)
      end
    end
    local openmailid = InboxFrame.openMailID
    if openmailid and openmailid > 0 then
      for slotid = 1, ATTACHMENTS_MAX_RECEIVE do
        local itemlink = GetInboxItemLink(openmailid, slotid)
        itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
        itemid = itemid and tonumber(itemid)
        local texture = _G["OpenMailAttachmentButton"..slotid.."IconTexture"]
        itemid = (not clear) and itemid
        addon:SlotColor(itemid, texture)
      end
    end
  end
end)


-- third party bag addons can plugin by calling either function below

-- returns r,g,b color components appropriate for the itemid
function addon:GetSlotColor(itemid)
  addon:SlotColor(itemid, addon.scantex, true)
  return addon.scantex:GetVertexColor()
end
-- sets the VertexColor of the provided texture as appropriate for the itemid
function addon:SlotColor(itemid, texture, resetcolor)
  if not texture then return end
  if itemid then
       local _, itemlink, _, _, _, itemtype, _, _, _, _ = GetItemInfo(itemid)
       if itemtype == addon.recipeClass() then
            local tname = texture:GetName() or "unnamed"
            if not addon.ttcache[itemid] then
              debug("Slot Scanning "..tname..": "..itemlink.." "..itemtype)
              addon.scantt:ClearLines()
              addon.scantt:SetOwner(UIParent, "ANCHOR_NONE");
              addon.scantt:SetHyperlink(itemlink)
            end
            local color = addon.ttcache[itemid] and addon.ttcache[itemid].ahcolor
            if color then -- second clause for RefreshTooltips
              local r,g,b = unpack(color)
              debug("Slot Coloring "..tname..": "..itemlink)
              texture:SetVertexColor(r,g,b) 
              return
            end
       end
       if resetcolor then
          texture:SetVertexColor(1,1,1) -- reset shading
       end
  else
    texture:SetVertexColor(1,1,1) -- reset shading
  end
end
-- -----------------------------------------------------------------------------
-- support for third-party bag addons

addon.bagnon_hook = function(itemslot) 
  local bank = itemslot.IsBankSlot and itemslot:IsBankSlot()
  if (bank and not settings.bankcolor) or
     (not bank and not settings.bagcolor) then return end
  local itemlink = itemslot.GetItem and itemslot:GetItem()
  local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
  itemid = itemid and tonumber(itemid)
  if itemid and addon:isRecipe(itemid) then
    local r,g,b = addon:GetSlotColor(itemid)
    SetItemButtonTextureVertexColor(itemslot,r,g,b)
  end
end

addon.arkinv_hook = function(frame)
  local name = frame and frame.GetName and frame:GetName( )
  if not name then return end
  --if not name or not string.match(name, "ContainerBag%d+Item%d+$") then return end
  local item = ArkInventory.Frame_Item_GetDB and ArkInventory.Frame_Item_GetDB(frame)
  local loc_id = item.loc_id
  if not item or not loc_id then return end
  local bank = ArkInventory.Const and ArkInventory.Const.Location and 
               (loc_id == ArkInventory.Const.Location.Vault or 
                loc_id == ArkInventory.Const.Location.Bank)
  if (bank and not settings.bankcolor) or
     (not bank and not settings.bagcolor) then return end

  local itemlink = item.h
  local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
  itemid = itemid and tonumber(itemid)
  local texture = _G[name.."IconTexture"]
  addon:SlotColor(itemid, texture)
end

addon.baggins_hook = function(self,bagframe,button,bag,slot) 
  if not bag or not slot or not button then return end
  local bank = (bag == -1) or (bag > NUM_BAG_SLOTS)
  if (bank and not settings.bankcolor) or
     (not bank and not settings.bagcolor) then return end
  local itemlink = GetContainerItemLink(bag, slot)
  local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
  local texture = button.glow
  itemid = itemid and tonumber(itemid)
  if itemid and addon:isRecipe(itemid) then
    local r,g,b = addon:GetSlotColor(itemid)
    SetItemButtonTextureVertexColor(button,r,g,b)
  end
end

addon.combuctor_hook = function(itemslot) 
  local bank = itemslot.IsBank and itemslot:IsBank()
  if (bank and not settings.bankcolor) or
     (not bank and not settings.bagcolor) then return end
  local itemlink = itemslot.GetItem and itemslot:GetItem()
  local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
  itemid = itemid and tonumber(itemid)
  if itemid and addon:isRecipe(itemid) then
    local r,g,b = addon:GetSlotColor(itemid)
    SetItemButtonTextureVertexColor(itemslot,r,g,b)
  end
end

-- -----------------------------------------------------------------------------
function addon:MERCHANT_SHOW()
  debug("MERCHANT_SHOW")
  addon:MerchantEvent()
end
function addon:MERCHANT_UPDATE()
  debug("MERCHANT_UPDATE")
  addon:MerchantEvent()
end
function addon:MERCHANT_CLOSED()
  debug("MERCHANT_CLOSED")
  addon:MerchantEvent()
end

function addon:MerchantEvent()
  local numitems = GetMerchantNumItems()
  if numitems == 0 then
    if useMerchantTimer and addon.merchantTimer then
      addon:CancelTimer(addon.merchantTimer, true)
      addon.merchantTimer = nil
    end
    return
  end
  if not addon.settings.merchantcolor then return end
  if useMerchantTimer and not addon.merchantTimer then
    addon.merchantTimer = addon:ScheduleRepeatingTimer("MerchantEvent", 0.5)
  end
  if not addon.merchantHooked and 
     MerchantPrevPageButton and MerchantNextPageButton and MerchantFrameTab1 then
    MerchantNextPageButton:HookScript("PostClick", function () addon:MerchantEvent() end)
    MerchantPrevPageButton:HookScript("PostClick", function () addon:MerchantEvent() end)
    MerchantFrameTab1:HookScript("PostClick", function () addon:MerchantEvent() end)
    addon.merchantHooked = true
  end
  if MerchantFrame.selectedTab ~= 1 then return end -- buyback tab
  
  for i=1,MERCHANT_ITEMS_PER_PAGE do
    local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i);
    if index > numitems then break end
    local itemButton = _G["MerchantItem"..i.."ItemButton"];
    local merchantButton = _G["MerchantItem"..i];
    if not itemButton or not merchantButton then break end
    local itemlink = GetMerchantItemLink(index)
    local itemid = itemlink and string.match(itemlink, "\124Hitem:(%d+):")
    itemid = itemid and tonumber(itemid)
    if itemid and addon:isRecipe(itemid) then
      local r,g,b = addon:GetSlotColor(itemid)
      SetItemButtonNameFrameVertexColor(merchantButton, r,g,b)
      SetItemButtonSlotVertexColor(merchantButton, r,g,b)
      SetItemButtonTextureVertexColor(itemButton, r,g,b)
      SetItemButtonNormalTextureVertexColor(itemButton, r,g,b)
    end
  end
end

function addon:SetAuctionColors()
  --debug("SetAuctionColors()")

  local pageoffset = 0
  if not addon.AuctioneerAdv then
    pageoffset = (BrowseScrollFrame and FauxScrollFrame_GetOffset(BrowseScrollFrame)) or 0
  end
  local pagesz, totalsz = GetNumAuctionItems("list")
  for i = 1, pagesz do
     local itemlink, itemidx, iconTexture
     if addon.AuctioneerAdv then
       local button = getglobal("BrowseButton"..i)
       if button and button:IsVisible() and button.id then
         itemidx = button.id
         iconTexture = button.Icon
         --iconTexture = getglobal("AppraiserIconButton"..i)
       end
     else
       itemidx = i+pageoffset
       iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture")
     end

     if not itemidx then break end
     itemlink = GetAuctionItemLink("list", itemidx)
     if not iconTexture or not itemlink then break end

     local itemid = string.match(itemlink, "\124Hitem:(%d+):")
     itemid = itemid and tonumber(itemid) 
     local resetcolor = false
     if addon.AuctioneerAdv then -- auctioneer doesnt reset colors so we have to
       local usable = select(5,GetAuctionItemInfo("list",itemidx))
       if not usable then
         iconTexture:SetVertexColor(1,0,0)
       else
         resetcolor = true
       end
     end
     addon:SlotColor(itemid, iconTexture, resetcolor)
  end

end

-- test code to find recipe mismatches, must be run per-language
-- run with no arguments to start a new default run or resume an interrupted run
-- run with minval and maxval to start a run on a specified range
function addon:TestRecipes(minval, maxval, status)
  local step = 25
  local pausetime = 1.0 
  local firstiter = false
  if not status then -- user initiated run
    firstiter = true
    if not minval and not maxval then -- default
      if settings.testrecipes_status and 
         settings.testrecipes_status.curval < settings.testrecipes_status.maxval then -- resume
	 status = settings.testrecipes_status
         chatMsg("Resuming itemid scan "..status.minval.." to "..status.maxval.." at "..status.curval.."...")
	 if #status.errors > 0 then
	   chatMsg("Errors detected so far:")
           for _,err in ipairs(status.errors) do
             chatMsg(err)
	   end
	 end
      else -- new run
         minval = minval or 0
         maxval = maxval or 100000
      end
    end
  end
  if not status then -- user initiated new run
    if not addon.db.global.JCDB or addon.db.global.JCDB.locale ~= locale then
      addon:ScanJC()
      if not addon.db.global.JCDB then return end
    end
      status = {
        minval = minval,
	curval = minval,
        maxval = maxval,
	count = {},
        start = GetTime(),
	elapsed = 0,
        errors = {},
      }
      settings.testrecipes_status = status
      chatMsg("Starting itemid test "..minval.." to "..maxval.."...")
  end
  addon:RefreshTooltips()
  if not addon.ScheduleTimer then
     LibStub("AceTimer-3.0"):Embed(addon)
  end
  local start = GetTime()
  maxval = math.min(status.curval + step - 1, status.maxval)
  local cachemax = math.min(status.curval + 2*step, status.maxval)
  for itemid=status.curval, cachemax do -- load the cache
      local itemname = GetItemInfo(itemid)
  end
 if not firstiter then
  chatMsg("Testing "..status.curval.." ...")
  local count = {}
  for itemid=status.curval, maxval do
    local itemname, itemlink, _, _, _, itemtype, profName, _, _, _ = GetItemInfo(itemid)
    if itemname then
       count.item = (count.item or 0) + 1
       if itemtype == addon.recipeClass() then
            addon.ttrecipe = false
            count.recipe = (count.recipe or 0) + 1
            if not addon.ttcache[itemid] then
              addon.scantt:SetHyperlink(itemlink)
            end
            if addon.ttrecipe and (not addon.ttcache[itemid] or addon.ttcache[itemid].biterr) 
               and not PV_DeadRecipes[itemid] then
               table.insert(status.errors, itemid.." "..itemlink)
            end
       else
         local crafttype = addon:isCraftedItem(itemid) 
	 if crafttype then
            addon.ttcrafted = false
            count[crafttype] = (count[crafttype] or 0) + 1
            if not addon.ttcache[itemid] then
              addon.scantt:SetHyperlink(itemlink)
            end
            if (not addon.ttcrafted or not addon.ttcache[itemid] or addon.ttcache[itemid].biterr) 
	       and not PV_DeadCrafted[itemid] then
               table.insert(status.errors, itemid.." "..itemlink)
            end
	 end
       end
    end
  end
  status.curval = maxval+1
  for k,v in pairs(count) do
    status.count[k] = (status.count[k] or 0) + (count[k] or 0)
  end
  status.elapsed = status.elapsed + (GetTime() - start)
 end
  if not firstiter and maxval == status.maxval then
    local tally = ""
    for k,v in pairs(status.count) do
      if #tally > 0 then tally = tally..", " end
      tally = tally .. (status.count[k] or 0) .. " " .. k .."s"
    end
    chatMsg("Tested itemids "..status.minval.." to "..status.maxval.." ("..tally..") in "..
          format("%.3f",status.elapsed).."/"..
	  format("%.3f",(GetTime() - status.start)).." sec - "..#status.errors.." errors.")
    for _,err in ipairs(status.errors) do
      chatMsg(err) 
    end
  else
    addon:ScheduleTimer(function () addon:TestRecipes(nil, nil, status) end, pausetime)
  end
end

--display length of a string, without escape codes
local function displaylen(s)
  s = string.gsub(s,"\124c........","")
  s = string.gsub(s,"\124r","")
  return #s
end

function addon:ShowTooltip(tt)
  local itemid, spellid, spellname, crafted
  local ttname = tt:GetName()
  --debug("ShowTooltip")
  if not ttname then return end

  local itemtext, itemlink = tt:GetItem()
  if itemtext and itemlink then -- recipes and crafted items
    itemid = string.match(itemlink, "\124Hitem:(%d+):")
    itemid = itemid and tonumber(itemid)
  else -- recipe spells
    --string.match(itemlink, "\124Henchant:(%d+):")
    spellname, _, spellid = tt:GetSpell()
    if not spellname or not spellid then return end
    spellid = spellid and tonumber(spellid)
  end
  if not itemid and not spellid then return end
  local cacheid = itemid or spellid+1000000
  --debug("ShowTooltip cacheid="..cacheid)

  if addon.ttcache[cacheid] then -- read from cache
    if #addon.ttcache[cacheid] > 0 then
      tt:AddLine(" ")
    end
    for _,l in ipairs(addon.ttcache[cacheid]) do
     local r,g,b = unpack(l.color)
     if ttwrapwidth == 0 then
      tt:AddLine(string.gsub(l.text,",",", "), r, g, b, true)
     else
      local txtc = { strsplit(",",l.text) }
      local t = ""
      for _,c in ipairs(txtc) do
        if displaylen(t) + displaylen(c) > ttwrapwidth then
          tt:AddLine(t..",", r, g, b)
          t = "           "..c
        elseif #t == 0 then
          t = c
        else
          t = t..", "..c
        end
      end -- for txtc
      if #t > 0 then
        tt:AddLine(t, r, g, b)
      end
     end 
    end -- for lines
    tt:Show()
    tt:Show()
  else -- build cache
    local profName, profLvl, profID
    if spellid then -- spell link
      local line = getglobal(ttname .. "TextLeft1")
      if not line then return end
      local text = line:GetText()
      if not text then return end
      profName = string.match(text, "^([^:]+): ")
      profID = allProf[profName] and allProf[profName].spellid
      profLvl = 0 -- TODO
    else -- item link
     local itemclass = select(6,GetItemInfo(itemid))
     if not itemclass then return end
     if (itemclass == addon.recipeClass()) then -- recipe item
      if settings.debug then
        local line = getglobal(ttname .. "TextLeft1")
	local text = line:GetText()
	if string.find(text,"etriev") then
	  debug(text.." for "..itemlink)
	  return
	end
      end
      spellname = string.match(itemtext, ":%s*(.+)$")
      if not spellname then return end

      for i=2,tt:NumLines() do
        local line = getglobal(ttname .. "TextLeft"..i)
        if not line then return end
        local text = line:GetText()
        if not text then return end
        profName, profLvl = string.match(text, strtrim(L["Requires"]).."%s*:?%s*(.+)%s+%((%d+)%)%s*$")
	if not profName then
          profName, profLvl = string.match(text, "(.+)%s+%((%d+)%)%s+"..strtrim(L["Requires"])) -- frFR
	end
	profName = profName and strtrim(profName)
        profLvl = profLvl and tonumber(profLvl)
        profID = allProf[profName] and allProf[profName].spellid
        if profID == PID_FISH or profID == PID_FA then addon.ttrecipe = false ; break end -- ignore fishing/first aid books
        if profName and profID and profLvl then addon.ttrecipe = true ; break end
      end
     elseif addon.settings.craftedtooltips then -- possible crafted item, determine spellname and profinfo
        local spns = {}
        if PV_Exceptions_ItoS[itemid] then 
	  table.insert(spns, itemid)
	else
	  table.insert(spns, itemtext) -- try base item first

	  local scroll_token = strtrim(L["Scroll of"])
	  if string.find(itemtext, scroll_token) then  -- handle scroll of enchant
	    local tmp = string.gsub(itemtext, scroll_token, "")
	    if locale == "deDE" then -- remove extra verbiage not present in spell
	      tmp = string.gsub(tmp, "hverzauberung", "he")
	      tmp = string.gsub(tmp, "n?verzauberung", "")
	    elseif locale == "ruRU" then -- convert "yap" used in scroll to plural "yapbl" used in spell
	      tmp = string.gsub(tmp, "(\208\167\208\176\209\128)", "$1\209\139")
	    end
            table.insert(spns, tmp)
	  end

	  table.insert(spns, xmute_token.." "..itemtext) -- try transmute
	end
        for _, spn in ipairs(spns) do
	  local idx
	  if type(spn) == "number" then -- exception itemid
	    idx = spn
	  else
	    idx = normalize(spn)
	    idx = (usehashes and addon:hash(idx)) or idx
	  end
          for pid,_ in pairs(PV_PatDBL) do
	    if PV_PatDBL[pid][idx] then
	      spellname = spn
	      profID = pid
	      profName = GetSpellInfo(pid)
	      profLvl = 0
	      crafted = true
	      addon.ttcrafted = true
	      break
	    end
	  end
	  if profName then break end
        end
     end -- crafted
    end -- item
    if not profName or not profID or not profLvl then return end
    debug(ttname..": "..profName.." ("..profLvl.."): "..spellname)
    local knownstr, learnstr, skillstr, dunnostr = "","","",""

    if not PV_PatDBL or not PV_PatDBL[profID] then return end
    spellname = normalize(spellname)
    local bitidx = PV_PatDBL[profID][(usehashes and addon:hash(spellname)) or spellname]
    -- some recipe names dont match their spell names, check for special cases
    if (not bitidx and itemid and PV_Exceptions_ItoS[itemid]) then
        --spellname = normalize(GetSpellInfo(PV_Exceptions_ItoS[itemid]))
        bitidx = PV_PatDBL[profID][itemid]
    end
    if (not bitidx and spellid and PV_Exceptions_StoI[spellid]) then
        local item = PV_Exceptions_StoI[spellid]
	if type(item) == "table" then item = item[1] end
        --spellname = normalize(GetSpellInfo(spellid))
        bitidx = PV_PatDBL[profID][item]
    end
    if (not bitidx and not (itemid and PV_DeadRecipes[itemid])) then -- some recipe names dont match their spell names, grr
      chatMsg(format(L["ERROR: Missing entry in pattern database: %s Please report this bug!"],
            format("%d %s: %s",(itemid or spellid),profName,spellname.."-"..GetLocale())))
	    --print(string.byte(spellname,1,#spellname))
    end

    local rtype = "unknown"
    local rval = rcolortable[rtype].order

    for cname,dbc in cpairs(DB.chars) do
      --print(cname)
      local isself = (cname == charName)
      local isalt = not isself and dbc.data and dbc.data.alt
      local isother = not isself and not isalt
      local difffaction = dbc.data and dbc.data.faction and dbc.data.faction ~= DBc.data.faction
      local coloredname,ctype = coloredcname(cname, settings.colorttnames)
      if (dbc[profName] and cname ~= einstein and not addon:isHidden(cname,profName) and 
	  (not difffaction or settings.factiondata) and
	  ((isself and settings.selfdata) or
	   (isalt and settings.altdata) or
	   (isother and settings.otherdata))
         ) then
        local pinfo = dbc[profName]
        if (pinfo.rank < profLvl) then
           skillstr = skillstr..((#skillstr > 0 and ",") or "") .. coloredname .. " (" .. pinfo.rank .. ")"
           ctype = "skill_"..ctype
        else 
	   if (not bitidx) then
             dunnostr = dunnostr..((#dunnostr > 0 and ",") or "") .. coloredname 
	     ctype = "dunno"
           elseif (addon:link_bit(pinfo.link, bitidx)) then
             knownstr = knownstr..((#knownstr > 0 and ",") or "") .. coloredname 
             ctype = "known_"..ctype
           else
             learnstr = learnstr..((#learnstr > 0 and ",") or "") .. coloredname 
             ctype = "learn_"..ctype
           end
        end
	local nrval = rcolortable[ctype].order -- calculate recipe color priority
	if nrval < rval then
	  rtype = ctype
	  rval = nrval
	end
      end
    end
   
    if addon.ttcachecnt > maxcachesz then
      addon.ttcache = {}
      addon.ttcachecnt = 1
    else
      addon.ttcachecnt = addon.ttcachecnt + 1
    end
    addon.ttcache[cacheid] = {}
    if not bitidx then
      addon.ttcache[cacheid].biterr = true
    end
   if crafted then
     local crafters = "("..profName..")"
     local craftcolor
     if #knownstr > 0 then
       crafters = knownstr
       craftcolor = settings.recipecolor["known_other"]
     else
       craftcolor = settings.recipecolor["unknown"]
     end
     table.insert(addon.ttcache[cacheid], { text = L["Craftable by"]..": "..crafters, color = craftcolor })
   else
    if #learnstr > 0 and profLvl == 0 then
      table.insert(addon.ttcache[cacheid], { text = L["Not Known"]..": "..learnstr, color = settings.recipecolor["unknown"] })
    elseif #learnstr > 0 then
      table.insert(addon.ttcache[cacheid], { text = L["Learnable"]..": "..learnstr, color = settings.recipecolor["learn_other"] })
    end
    if #skillstr > 0 then
      table.insert(addon.ttcache[cacheid], { text = L["Skill too low"]..": "..skillstr, color = settings.recipecolor["skill_other"] })
    end
    if #knownstr > 0 then
      table.insert(addon.ttcache[cacheid], { text = L["Known"]..": "..knownstr, color = settings.recipecolor["known_other"] })
    end
    if #dunnostr > 0 then
      table.insert(addon.ttcache[cacheid], { text = L["Not sure"]..": "..dunnostr, color = settings.recipecolor["dunno"] })
    end
    addon.ttcache[cacheid].ahcolor = settings.recipecolor[rtype]
   end
   addon:ShowTooltip(tt)
  end
end

addon.DropDownMenu = CreateFrame("Frame", addonName.."_DropDownMenu")
addon.DropDownMenu.displayMode = "MENU"
addon.DropDownMenu.onHide = function(...)
        MenuParent = nil
        MenuItem = nil
end

function addon:ShowDropdown(cname, pname)
        addon.DropDownMenu.cname = cname
        addon.DropDownMenu.pname = pname
        GameTooltip:Hide()
        HideDropDownMenu(1)
        ToggleDropDownMenu(1, nil, addon.DropDownMenu, "cursor", 0, 0)
end

local menuinfo = {}
addon.DropDownMenu.initialize = function(self, level)
        local cname, pname = addon.DropDownMenu.cname, addon.DropDownMenu.pname
        if not level then return end
        wipe(menuinfo)
        if level == 1 then
                -- Create the title of the menu
                menuinfo.isTitle = 1
                menuinfo.text = cname..((pname and (" / "..pname)) or "")
                menuinfo.notCheckable = 1
                UIDropDownMenu_AddButton(menuinfo, level)

                menuinfo.isTitle      = nil
                menuinfo.notCheckable = nil

                menuinfo.text = L["Whisper this player"]
                menuinfo.disabled = (cname == einstein) or (cname == charName)
                menuinfo.arg1 = nil
                menuinfo.func = function(button, arg1)
                        ChatFrame_SendTell(cname)
                      end
                UIDropDownMenu_AddButton(menuinfo, level)

                menuinfo.text = L["Invite this player"]
                menuinfo.disabled = (cname == einstein) or (cname == charName)
                menuinfo.arg1 = nil
                menuinfo.func = function(button, arg1)
                        InviteUnit(cname)
                      end
                UIDropDownMenu_AddButton(menuinfo, level)

                menuinfo.text = L["Delete this entry"]
                menuinfo.disabled = (cname == einstein) or (cname == charName and pname and GetSpellLink(pname))
                menuinfo.arg1 = nil
                menuinfo.func = function(button, arg1)
		        local setselect
                        if pname then
                           DB.chars[cname][pname] = nil
			   setselect = function() settings.treepath = { settings.treepath[1] } end
                        else
                           DB.chars[cname] = nil
			   setselect = function() settings.treepath = nil end
                           addon:RefreshChar()
                        end
			addon:RefreshWindow(setselect)
			end
                UIDropDownMenu_AddButton(menuinfo, level)

                menuinfo.text = L["Hide this entry"]
                menuinfo.disabled = false
                menuinfo.arg1 = nil
                menuinfo.func = function(button, arg1)
		        local pat = "/"..(pname or "*")
			if not cname or (cname == einstein and settings.grpbyprof) then
			   pat = "*"..pat
			else
			   pat = cname..pat
			end
		        DB.hide[pat] = true
			debug("Hiding "..pat)
			addon:RefreshWindow(function() settings.treepath = { settings.treepath[1] } end)
			addon:RefreshTooltips()
			end
                UIDropDownMenu_AddButton(menuinfo, level)

		if (not pname or settings.grpbyprof) then
                  menuinfo.text = L["Is an alt"]
                  menuinfo.disabled = (cname == einstein)
                  menuinfo.arg1 = nil
                  menuinfo.checked = (DB.chars[cname].data.alt == true)
                  menuinfo.func = function(button, arg1, arg2, checked)
		        checked = not checked
		        debug("Set cname alt flag to: "..(checked and "true" or "false"))
                        DB.chars[cname].data.alt = checked
			addon:RefreshWindow()
			addon:RefreshTooltips()
                      end
                  UIDropDownMenu_AddButton(menuinfo, level)
		end

                -- Close menu item
                menuinfo.disabled     = nil
                menuinfo.text         = CLOSE
                menuinfo.func         = function() CloseDropDownMenus() end
                menuinfo.checked      = nil
                menuinfo.notCheckable = 1
                UIDropDownMenu_AddButton(menuinfo, level)
        end
end
