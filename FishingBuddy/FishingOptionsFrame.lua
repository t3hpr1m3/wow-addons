-- Handle all the option settings

local FL = LibStub("LibFishing-1.0");

local FBOptionsTable = {};

local function FindOptionInfo (setting)
	for _,info in pairs(FBOptionsTable) do
		if ( info.options[setting] ) then
			return info;
		end
	end
	-- return nil;
end

local function GetDefault(setting)
	local info = FindOptionInfo(setting);
	if ( info ) then
		local opt = info.options[setting];
		if ( opt ) then
			if ( opt.check and opt.checkfail ) then
				if ( not opt.check() ) then
					return opt.checkfail;
				end
			end
			return opt.default;
		end
	end
	-- return nil;
end
FishingBuddy.GetDefault = GetDefault;

local function GetSetting(setting)
	local val = nil;
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if ( info ) then
			val = info.getter(setting);
			if ( val == nil ) then
				val = GetDefault(setting);
			end
		else
			val = FishingBuddy.BaseGetSetting(setting);
		end
	end
	return val;
end
FishingBuddy.GetSetting = GetSetting;

local function GetSettingBool(setting)
	local val = GetSetting(setting);
	return val == 1;
end
FishingBuddy.GetSettingBool = GetSettingBool;

local function SetSetting(setting, value)
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if ( info ) then
			local val = GetDefault(setting);
			if ( val == value ) then
				info.setter(setting, nil);
			else
				info.setter(setting, value);
			end
		else
			FishingBuddy.BaseSetSetting(setting, value);
		end
	end
end
FishingBuddy.SetSetting = SetSetting;

local function GetSettingOption(setting)
	local val = nil;
	if ( setting ) then
		local info = FindOptionInfo(setting);
		if (info) then
			return info.options[setting];
		end
	end
	-- return nil;
end
FishingBuddy.GetSettingOption = GetSettingOption;

-- display all the option settings
FishingBuddy.OptionsFrame = {};

local function ParentValue(button)
	local value = 1;
	if ( button.parents ) then
		for _,b in pairs(button.parents) do
			if ( b.checkbox and not b:GetChecked() ) then
				value = 0;
			end
		end
	end
	return value;
end

-- we only set value if we need to force a behavior
local function CheckBox_Able(button, value)
	if ( not button ) then
		return;
	end
	if ( value == nil ) then
		value = ParentValue(button);
	end
	local color;
	if ( value == 1 ) then
		if (button.checkbox) then
			button:Enable();
		end
		color = NORMAL_FONT_COLOR;
	else
		if ( button.checkbox ) then
			button:Disable();
		end
		color = GRAY_FONT_COLOR;
	end
	local text = getglobal(button:GetName().."Text");
	if ( text ) then
		text:SetTextColor(color.r, color.g, color.b);
	end
end

local function hideOrDisable(button, what)
	local value = ParentValue(button);
	if ( type(what) == "function" ) then
		what, value = what();
	end
	if ( what == "d" ) then
		CheckBox_Able(button, value);
	elseif ( what == "h" ) then
		 button:Hide();
		 if ( value == 1 ) then
			if ( not button.visible or button.visible() == 1 ) then
				button:Show();
			end
		end
	end
end

local function CheckButton_HandleDeps(parent)
	if ( parent.deps ) then
		local value = (not parent.checkbox or parent:GetChecked() ~= nil) and 1 or 0;
		for dep,what in pairs(parent.deps) do
			hideOrDisable(dep, what);
			CheckButton_HandleDeps(dep);
		end
	end
end

local function CheckButton_OnShow(button)
	button:SetChecked(GetSetting(button.name));
end
FishingBuddy.CheckButton_OnShow = CheckButton_OnShow;

local function CheckButton_OnClick(button, quiet)
	if ( not button ) then
		return;
	end
	local value = 1;
	if ( button.checkbox) then
		if ( not button:GetChecked() ) then
			value = 0;
		end
		if ( not quiet ) then
			if ( value ) then
				PlaySound("igMainMenuOptionCheckBoxOn");
			else
				PlaySound("igMainMenuOptionCheckBoxOff");
			end
		end
	end
	SetSetting(button.name, value);
	FishingBuddy.OptionsUpdate();
	if ( button.update ) then
		button.update(button);
	end
	CheckButton_HandleDeps(button);
end
FishingBuddy.CheckButton_OnClick = CheckButton_OnClick;

local function Slider_OnLoad(self, info, height, width)
	self.info = info;
	self.textfield = getglobal(info.name.."Text");
	getglobal(info.name.."High"):SetText();
	getglobal(info.name.."Low"):SetText();
	self:SetMinMaxValues(info.min, info.max);
	self:SetValueStep(info.step or 1);
	self:SetHeight(height or 17);
	self:SetWidth(width or 130);
end

local function Slider_OnShow(self)
	local where = FishingBuddy.GetSetting(self.info.setting);
	if (where) then
		self:SetValue(where);
		self.textfield:SetText(string.format(self.info.format, where));
	end
end

local function Slider_OnValueChanged(self)
	local where = self:GetValue();
	self.textfield:SetText(string.format(self.info.format, where));
	FishingBuddy.SetSetting(self.info.setting, where);
	if (self.info.action) then
		action(self);
	end
end

-- info contains
-- name
-- format -- how to print the value
-- min
-- max
-- step -- default to 1
-- rightextra -- extra room needed, if any
-- setting -- what this slider changes
local function Slider_Create(info)
	local s = CreateFrame("Slider", info.name, nil, "OptionsSliderTemplate");
	Slider_OnLoad(s, info);
	s:SetScript("OnShow", Slider_OnShow);
	s:SetScript("OnValueChanged", Slider_OnValueChanged);
	return s;
end
FishingBuddy.Slider_Create = Slider_Create;

local optionbuttons = {};
local optionmap = {};

local function processdeps(button, deps)
	for n,what in pairs(deps) do
		local b = optionmap[n];
		if ( b ) then
			if ( not b.deps ) then
				b.deps = {};
			end
			b.deps[button] = what;
			if ( not button.parents ) then
				button.parents = {};
			end
			tinsert(button.parents, b);
		end
	end
end

local function orderbuttons(btnlist)
	if not btnlist then
		return {};
	end
	
	table.sort(btnlist, function(a,b)
		if ( a.custom ) then
			return false;
		else
			return a.width and b.width and a.width < b.width;
		end
	end);
	local order = {};
	local used = {};
	for idx=1,#btnlist do
		local b = btnlist[idx];
		if (b.deps and not used[b.name] ) then
			local group = {};
			local last = {};
			used[b.name] = 1;
			tinsert(order, idx);
			for d,_ in pairs(b.deps) do
				for jdx=1,#btnlist do
					if ( not used[d.name] and btnlist[jdx].name == d.name) then
						used[d.name] = 1;
						if (d.custom) then
							tinsert(last, jdx);
						else
							tinsert(group, jdx);
						end
					end
				end
			end
			-- here we should arrange order so that as many pairs as possible are
			-- an appropriate width. For now make all the odd ones the shortest ones.
			for jdx=1,#group do
				local kdx = #group-jdx+1;
				if (kdx > jdx) then
					tinsert(order, group[jdx]);
					tinsert(order, group[kdx]);
				elseif (kdx == jdx) then
					tinsert(order, group[jdx]);
				end
			end
			for jdx=1,#last do
				tinsert(order, last[jdx]);
			end
		end
	end
	local last = {};
	local group = {};
	for idx=1,#btnlist do
		local b = btnlist[idx];
		if ( not used[b.name] ) then
			if (b.custom) then
				tinsert(last, idx);
			else
				tinsert(group, idx);
			end
		end
	end

	for jdx=1,#group do
		local kdx = #group-jdx+1;
		if (kdx > jdx) then
			tinsert(order, group[jdx]);
			tinsert(order, group[kdx]);
		elseif (kdx == jdx) then
			tinsert(order, group[jdx]);
		end
	end
	for jdx=1,#last do
		tinsert(order, last[jdx]);
	end

	return order;
end

local function Setup(options, nomap)
	FishingOptionsFrame.groupoptions = options;
	
-- Clear out all the stuff we put on the old buttons
	for name,button in pairs(optionmap) do
		button.name = nil;
		button.width = 0;
		button.slider = 0;
		button.update = nil;
		button.text = "";
		button.tooltipText = nil;
		button.primary = nil;
		button.deps = nil;
		button.right = nil;
		button.layoutright = nil;
		button.margin = nil;
		button.visible = nil;
		button.adjacent = nil;
		button.parents = nil;
		CheckBox_Able(button, 0);
		button:ClearAllPoints();
		if (button.checkbox) then
			button:SetHitRectInsets(0, -100, 0, 0);
		end
		button.custom = nil;
		button:Hide();
	end
	optionmap = {};
	
	local index = 1;
	for name,option in pairs(options) do
		local button = nil;
		if ( option.button ) then
			button = getglobal(option.button);
			if ( button ) then
				button.custom = 1;
				button.checkbox = (button:GetObjectType() == "CheckButton");
				if ( not nomap ) then
					button:ClearAllPoints();
					button:SetParent(FishingOptionsFrame);
				end
				if ( option.v ) then
					button:SetScript("OnShow", CheckButton_OnShow);
					button:SetScript("OnClick", CheckButton_OnClick);
				end
			end
		elseif ( option.v ) then
			button = optionbuttons[index];
			if ( not button ) then
				button = CreateFrame(
					"CheckButton", "FishingBuddyOption"..index,
					FishingOptionsFrame, "OptionsSmallCheckButtonTemplate");
				-- override OnShow and OnClick
				button:SetScript("OnShow", CheckButton_OnShow);
				button:SetScript("OnClick", CheckButton_OnClick);
				-- use default OnEnter and OnLeave
			end
			optionbuttons[index] = button;
			button.checkbox = 1;
		end
		if ( button ) then
			if ( not nomap ) then
				optionmap[name] = button;
				button:SetFrameLevel(FishingOptionsFrame:GetFrameLevel() + 2);
			end
			button.name = name;
			button.layoutright = option.layoutright;
			button.margin = option.margin;
			button.name = name;
			button.update = option.update;
			button.visible = option.visible;
			button.width = button:GetWidth();
			if ( option.text ) then
				button.text = option.text;
				local text = getglobal(button:GetName().."Text");
				if (text) then
					text:SetText(option.text);
					button.width = button.width + text:GetWidth();
				end
			else
				button.text = "";
			end
			if ( button.checkbox ) then
				button:SetChecked(GetSetting(name));
			end
			button.tooltipText = option.tooltip;
			-- hack for sliders (why?)
			if (button:GetObjectType() == "Slider") then
				button.slider = 16;
			else
				button.slider = 0;
			end
			if ( option.setup ) then
				option.setup(button);
			end
			index = index + 1;
		end
	end
	
	local toplevel = {};
	for name,option in pairs(options) do
		local button = optionmap[name];
		if ( button ) then
			if ( option.deps ) then
				button.primary = option.primary;
				processdeps(button, option.deps);
			else
				tinsert(toplevel, name);
			end
		end
	end

	-- move the primaries with no dependents to the top, and stack them next to other
	-- then put everything else underneath. need to make the dep button layout code
	-- useful for the toplevel non-dep buttons then
	local primaries = {};
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and not button.deps and not button.custom ) then
			tinsert(primaries, name);
		end
	end
	local pb = {};
	for _,name in ipairs(primaries) do
		local b = optionmap[name];
		tinsert(pb, b);
	end

	local lastbutton = nil;
	local maxwidth = 0;
	local order = orderbuttons(pb);
	for iorder,index in ipairs(order) do
		local name = primaries[index];
		local button = optionmap[name];
		if ( not lastbutton ) then
			button:SetPoint("TOPLEFT", 32, -82);
			lastbutton = button;
		else
			local yoff = 0;
			if ( button.margin ) then
				yoff = yoff - button.margin[1] or 0;
			end
			if ( (iorder % 2) == 0 ) then
				if (lastbutton.margin) then
					yoff = yoff + lastbutton.margin[1] or 0;
				end
				button.adjacent = lastbutton;
				button:SetPoint("TOP", lastbutton, "TOP", 0, 0);
				if ( not button.custom and button.width > maxwidth ) then
					maxwidth = button.width;
				end
				button.right = 1;
			else
				button:SetPoint("TOPLEFT", lastbutton, "BOTTOMLEFT", lastoff, yoff);
				lastbutton = button;
			end
		end
	end
	for iorder,index in ipairs(order) do
		local name = primaries[index];
		local button = optionmap[name];
		if (button.right) then
			if ( button.checkbox ) then
				button:SetPoint("RIGHT", FishingOptionsFrame, "RIGHT", -32-maxwidth, 0);
				button:SetHitRectInsets(0, -maxwidth, 0, 0);
			else
				button:SetPoint("LEFT", FishingOptionsFrame, "RIGHT", -32-button.width-button.slider, 0);
			end
		end
	end
	
	primaries = {};
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and button.deps ) then
			tinsert(primaries, name);
		end
	end
	for _,name in pairs(toplevel) do
		local button = optionmap[name];
		if ( button and button.custom ) then
			tinsert(primaries, name);
		end
	end

	local lastoff = 0;
	for _,name in pairs(primaries) do
		local button = optionmap[name];
		if ( not lastbutton ) then
			button:SetPoint("TOPLEFT", 32, -82);
		else
			local yoff = 2;
			if ( button.margin ) then
				yoff = yoff - button.margin[1];
			end
			if ( lastbutton.margin ) then
				yoff = yoff - lastbutton.margin[2];
			end
			button:SetPoint("TOPLEFT", lastbutton, "BOTTOMLEFT", lastoff, yoff);
		end
		lastbutton = button;
		lastoff = 0;
		if ( button.deps ) then
			local deps = {};
			for b,n in pairs(button.deps) do
				if ( optionmap[b.name] and (not b.primary or b.primary == name) and b.name ~= button.layoutright) then
					tinsert(deps, b);
				end
			end
			local order = orderbuttons(deps);
			maxwidth = 0;
			local rlast = nil;
			local llast = nil;
			for iorder,index in ipairs(order) do
				local colbut = deps[index];
				if ( colbut ) then
					local yoff = 0;
					if ( colbut.margin ) then
						yoff = yoff - colbut.margin[1] or 0;
					end
					if ( (iorder % 2) == 1 ) then
						colbut:SetPoint("TOPLEFT", lastbutton, "BOTTOMLEFT", 16+lastoff, yoff);
						lastbutton = colbut;
						llast = colbut;
						lastoff = -16;
					else
						if (lastbutton.margin) then
							yoff = yoff + lastbutton.margin[1] or 0;
						end
						colbut.adjacent = lastbutton;
						colbut:SetPoint("TOP", lastbutton, "TOP", 0, yoff);
						if ( not colbut.custom and colbut.width > maxwidth ) then
							maxwidth = colbut.width;
						end
						colbut.right = 1;
					end
				end
			end
			for index=1,#deps do
				local colbut = deps[index];
				if (colbut.right) then
					if ( colbut.checkbox ) then
						colbut:SetPoint("RIGHT", FishingOptionsFrame, "RIGHT", -32-maxwidth, 0);
						colbut:SetHitRectInsets(0, -maxwidth, 0, 0);
					else
						colbut:SetPoint("LEFT", FishingOptionsFrame, "RIGHT", -32-colbut.width-colbut.slider, 0);
					end
				end
			end
		end
		if ( button.layoutright ) then
			 local toright = optionmap[button.layoutright];
			 if (toright) then
				 toright:ClearAllPoints();
				 toright:SetPoint("CENTER", button, "CENTER", 0, 0);
				 toright:SetPoint("RIGHT", FishingOptionsFrame, "RIGHT", -32, 0);
			 end
		end
	end
end

-- handle option panel tabs
local tabbuttons = {};
local tabmap = {};

local function showallbuttons()
	-- now that we've collected all of the dependencies, handle them
	for name,button in pairs(optionmap) do
		local button = optionmap[name];
		if ( button ) then
			local showit = 1;
			if ( button.visible ) then
				showit = button.visible();
			end
			if ( showit ) then
				button:Show();
			else
				button:Hide();
			end
		end
	end
	for name,button in pairs(optionmap) do
		if ( not button.parents ) then
			CheckBox_Able(button, 1);
			CheckButton_HandleDeps(button);
		end
	end
end

local function OptionTab_OnClick(self, button)
	local name = self.name;
	if ( FishingOptionsFrame.selected ~= name ) then
		local lasttab = tabmap[FishingOptionsFrame.selected];
		if ( lasttab ) then
			lasttab:SetChecked(nil);
			FishingBuddy.OptionsUpdate();
		end
		FishingOptionsFrame.selected = name;
		Setup(FBOptionsTable[name].options);
		showallbuttons();
	end
	tabmap[name]:SetChecked(1);
end

local function PositionTab(tab, prevtab)
	tab:ClearAllPoints();
	if ( prevtab ) then
		tab:SetPoint("TOPLEFT", prevtab, "BOTTOMLEFT", 0, -17);
	else
		tab:SetPoint("TOPLEFT", FishingOptionsFrame, "TOPRIGHT", -32, -65);
	end
	tab:Show();
end

local function UpdateTabs()
	local prevtab = nil;
	local lasttab = nil;
	for index,tab in ipairs(tabbuttons) do
		local name = tab.name;
		local handler = FBOptionsTable[name];
		if ( handler.first and handler.visible ) then
			PositionTab(tab);
			prevtab = tab;
		end
		if ( handler.last and handler.visible ) then
			lasttab = tab;
		end
	end
	for index,tab in ipairs(tabbuttons) do
		local name = tab.name;
		local handler = FBOptionsTable[name];
		if ( handler.visible ) then
			if ( not handler.first and not handler.last ) then
				PositionTab(tab, prevtab);
				prevtab = tab;
			 end
		else
			tab:Hide();
		end
	end
	if ( lasttab ) then
		PositionTab(lasttab, prevtab);
	end
end

local INV_MISC_QUESTIONMARK = "Interface\\Icons\\INV_Misc_QuestionMark";
local function HandleOptions(name, icon, options, setter, getter, last)
	local index = #tabbuttons + 1;
	local handler = {};
	local maketab = (name ~= nil);
	if ( not name ) then
		name = "FBHIDDEN";
		handler.index = 0;
		-- handle option buttons that show up outside of option frames
		Setup(options, 1);
	end
	if ( name == GENERAL ) then
		handler.first = true;
	end
	handler.last = last;
	handler.name = name;
	handler.icon = icon or INV_MISC_QUESTIONMARK;
	handler.options = FL:copytable(options);
	handler.setter = setter or FishingBuddy.BaseSetSetting;
	handler.getter = getter or FishingBuddy.BaseGetSetting;
	handler.visible = maketab;
	if ( FBOptionsTable[name] ) then
		for name,info in pairs(FBOptionsTable[name].options) do
			handler.options[name] = FL:copytable(info);
		end
		handler.index = FBOptionsTable[name].index;
	end
	FBOptionsTable[name] = handler;

	-- just handle the setting and getting if no name supplied
	if ( maketab ) then
		local optiontab = tabmap[name];
		if ( not optiontab ) then
			optiontab = CreateFrame(
						"CheckButton", "FishingBuddyOptionTab"..index,
						FishingOptionsFrame, "SpellBookSkillLineTabTemplate");
			optiontab:SetScript("OnClick", OptionTab_OnClick);
			optiontab.name = name;
			optiontab.tooltip = name;
			optiontab:SetNormalTexture(handler.icon);
			tinsert(tabbuttons, optiontab);
			tabmap[name] = optiontab;
			handler.index = index;
		end
	end
end
FishingBuddy.OptionsFrame.HandleOptions = HandleOptions;

local function HideOptionsTab(name)
	if ( FBOptionsTable[name] and FBOptionsTable[name].visible ) then
		FBOptionsTable[name].visible = nil;
		UpdateTabs();
	end
end
FishingBuddy.HideOptionsTab = HideOptionsTab;

local function ShowOptionsTab(name)
	if ( FBOptionsTable[name] and not FBOptionsTable[name].visible ) then
		FBOptionsTable[name].visible = true;
		UpdateTabs();
	end
end
FishingBuddy.ShowOptionsTab = ShowOptionsTab;

local function OptionsFrame_OnShow(self)
	UpdateTabs();
	showallbuttons();
	local selected = FishingOptionsFrame.selected;
	local first = nil;
	for name,handler in pairs(FBOptionsTable) do
		if ( handler.visible ) then
			if ( not first or handler.first ) then
				first = name;
			end
		else
			if ( selected == name ) then
				selected = nil;
			end
		end
	end
	if ( not selected and first ) then
		selected = first;
	end
	for name,tab in pairs(tabmap) do
		if ( selected == name ) then
			if ( not tab:GetChecked() ) then
				OptionTab_OnClick(tab);
			end
		else
			tab:SetChecked(nil);
		end
	end
	FishingOptionsFrame.selected = selected;
end

local function OptionsFrame_OnHide(self)
	for _,tab in pairs(tabmap) do
		tab:Hide();
	end
	FishingBuddy.OptionsUpdate();
end

-- Drop-down menu support
local function ToggleSetting(setting)
	local value = GetSetting(setting);
	if ( not value ) then
		value = 0;
	end
	SetSetting(setting, 1 - value);
	FishingBuddy.OptionsUpdate(true);
end
FishingBuddy.ToggleSetting = ToggleSetting;

-- save some memory by keeping one copy of each one
local ToggleFunctions = {};
-- let's use closures
local function MakeToggle(name, callme)
	if ( not ToggleFunctions[name] ) then
		local n = name;
		local c = callme;
		ToggleFunctions[name] = function() ToggleSetting(n); if (c) then c() end; end;
	end
	return ToggleFunctions[name];
end
FishingBuddy.MakeToggle = MakeToggle;

local function MakeDropDownEntry(switchText, switchSetting, keepShowing, callMe)
	info = {};
	info.text = switchText;
	info.func = MakeToggle(switchSetting, callMe);
	info.checked = FishingBuddy.GetSettingBool(switchSetting);
	info.keepShownOnClick = keepShowing;
	UIDropDownMenu_AddButton(info);
end
FishingBuddy.MakeDropDownEntry = MakeDropDownEntry;

local function MakeDropDownSep()
	info = {};
	info.disabled = 1;
	UIDropDownMenu_AddButton(info);
end
FishingBuddy.MakeDropDownSep = MakeDropDownSep;

FishingBuddy.MakeDropDown = function(switchText, switchSetting)
	local info;
	-- If no outfit frame, we can't switch outfits...
	if ( FishingBuddy.OutfitManager.HasManager() ) then
		MakeDropDownEntry(switchText, switchSetting, 1);
		MakeDropDownSep();
	end

	for _,info in pairs(FBOptionsTable) do
		for name,option in pairs(info.options) do
			if ( option.m ) then
				local addthis = true;
				if ( option.check ) then
					addthis = option.check();
				end
				if ( addthis ) then
					info = {};
					info.text = option.text;
					info.func = MakeToggle(name);
					info.checked = FishingBuddy.GetSettingBool(name);
					info.keepShownOnClick = 1;
					UIDropDownMenu_AddButton(info);
				end
			end
		end
	end
end

FishingBuddy.GetOptionList = function()
	local options = {};
	for _,info in pairs(FBOptionsTable) do
		for name,option in pairs(info.options) do
			options[name] = option;
		end
	end
	return options;
end

-- Create the options frame, unmanaged -- we get managed specially later
local f = FishingBuddy.CreateManagedFrame("FishingOptionsFrame");
f:SetScript("OnShow", OptionsFrame_OnShow);
f:SetScript("OnHide", OptionsFrame_OnHide);
