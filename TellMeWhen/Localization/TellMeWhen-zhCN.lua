--[[ Credit for these translations goes to:
	lsjyzjl
	wowuicn
--]]
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "zhCN", false)
if not L then return end


L["ACTIVE"] = "%d 作用中"
L["AIR"] = "空气图腾"
L["ALLOWCOMM"] = "允许图标导入"
L["ALLOWVERSIONWARN"] = "新版本通知"
L["ALPHA"] = "透明度"
L["ANN_CHANTOUSE"] = "使用频道"
L["ANN_EDITBOX"] = "要输出的文字内容"
L["ANN_EDITBOX_DESC"] = [=[输入事件触发时你想输出的文字内容.

可以使用下列的单位变量:

%s

"%s" - ​​当前被检测的法术/物品/等等
"%d" - 图标计时器的剩余时间
"%k" - 当前叠加数量]=]
L["ANN_EDITBOX_WARN"] = "在此输入你想要输出的文字内容"
L["ANN_EVENT_GLOBALDESC"] = "在此列表中的事件是按照从上到下的顺序来检测.如果一个事件触发并且输出了文字内容,在它之后的事件将不再输出任何文字内容."
L["ANN_SHOWICON"] = "显示图标材质"
L["ANN_SHOWICON_DESC"] = "一些文本目标能随文字内容一起显示一个材质.勾选此项启用该功能."
L["ANN_STICKY"] = "静态模式"
L["ANN_SUB_CHANNEL"] = "输出位置"
L["ANN_TAB"] = "文字输出"
L["ANN_UNITSUBSTITUTIONS"] = [=["%t" - 目标的名字
"%f" - 焦点目标的名字
"%m" - 鼠标悬停目标的名字
"%u" - 当前被检测的单位的名字
"%s" - ​​当前被检测的法术/物品/等的名字]=]
L["ANN_WHISPERTARGET"] = "悄悄话目标"
L["ANN_WHISPERTARGET_DESC"] = [=[输入你想要密语的玩家名字,仅可密语同服务器/同阵营的玩家.可以使用下列的单位变量:

%s]=]
L["ASCENDING"] = "升序"
L["ASPECT"] = "守护"
L["AURA"] = "光环"
L["BleedDamageTaken"] = "受到的流血伤害效果提高"
L["Bleeding"] = "流血效果"
L["BonusAgiStr"] = "敏捷/力量提高"
L["BonusArmor"] = "护甲提高"
L["BonusMana"] = "魔法值上限提高"
L["BonusStamina"] = "耐力提高"
L["BOTTOM"] = "下"
L["BOTTOMLEFT"] = "左下"
L["BOTTOMRIGHT"] = "右下"
L["BUFFCNDT_DESC"] = [=[只有第一个法术会被检测,其他的将全部被忽略.
输入法术ID时不会强制跟它们所对应的效果進行匹配,仅使用名称时必须匹配.]=]
L["BUFFTOCHECK"] = "要检测的增益"
L["BUFFTOCOMP1"] = "进行比较的第一个增益"
L["BUFFTOCOMP2"] = "进行比较的第二个增益"
L["BurstHaste"] = "英勇/嗜血"
L["BurstManaRegen"] = "突发性法力恢复"
L["CACHING"] = [=[TellMeWhen正在缓存和筛选游戏中的所有法术.
这只需要在每次魔兽世界补丁升级之后完成一次.您可以使用下方的滑杆加快或减慢过程.]=]
L["CACHINGSPEED"] = "法术缓存速度(每帧法术):"
L["CASTERFORM"] = "施法者姿态"
L["CENTER"] = "居中"
L["CHAT_FRAME"] = "聊天窗口"
L["CHAT_MSG_CHANNEL"] = "聊天频道"
L["CHAT_MSG_CHANNEL_DESC"] = "将输出到一个聊天频道,例如交易频道或是你加入的某个自定义频道."
L["CHAT_MSG_SMART"] = "智能频道"
L["CHAT_MSG_SMART_DESC"] = "此频道会自行选择最合适的输出频道.(仅限于:战场,团队,队伍,或说)"
L["CHECKORDER"] = "更新排列"
L["CHECKORDER_GROUPDESC"] = "更改此项将会按照设置来更新此分组的排序.只会在你需要使用检测 整合图标 的子元时用到.(子元指添加到整合图标列表中的整合图标)"
L["CHECKORDER_ICONDESC"] = "勾选此项将会按照设置来更新此分组中的图标的排序.只会在你需要使用检测 整合图标 的子元时用到.(子元指添加到整合图标列表中的整合图标)"
L["CHOOSENAME_DIALOG"] = [=[输入你想让此图标监视的名称或ID.你可以利用';'(分号)输入多个条目(名称/ID/同类型的任意组合).

你可以按住Shift再按鼠标左键点选法术/物品/聊天连结或者拖曳法术/物品添加到此编辑框中.]=]
L["CHOOSENAME_DIALOG_CNDTIC"] = "输入你要使用的法术材质名称或ID.你也可以输入一个材质路径,例如'Interface/Icons/spell_nature_healingtouch', 假如材质路径为'Interface/Icons'可以只输入'spell_nature_healingtouch'."
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "预定义的法术设置"
L["CHOOSENAME_DIALOG_MSCD"] = "输入你要此图标监视的名称或者ID,仅第一个法术/物品会被检测,使用分号分隔的列表不适用此图标类型."
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959宠物技能|r必须使用法术ID."
L["CHOOSENAME_EQUIVS_TOOLTIP"] = "你可以在此菜单选择预设的增益/减益,法术施放,递减,或者驱散类型(魔法,诅咒等.)插入到\"%s\"编辑框中."
L["CMD_OPTIONS"] = "选项"
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "玩家属性/状态"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "单位属性/状态"
L["CNDTCAT_BUFFSDEBUFFS"] = "增益/减益"
L["CNDTCAT_CURRENCIES"] = "货币"
L["CNDTCAT_FREQUENTLYUSED"] = "常用条件"
L["CNDTCAT_RESOURCES"] = "能量类型"
L["CNDTCAT_SPELLSABILITIES"] = "法术/物品"
L["CNDTCAT_STATS"] = "战斗统计(人物属性)"
L["CNDT_ONLYFIRST"] = "仅第一个法术/物品会被检测,使用分号分隔的列表不适用此条件类型."
L["CODETOEXE"] = "要执行的代码"
L["COLOR_CBC"] = "冷却条 - 完成"
L["COLOR_CBC_DESC"] = "冷却/持续时间计量条在冷却/持续时间已完成时的颜色"
L["COLOR_CBS"] = "冷却条 - 开始"
L["COLOR_CBS_DESC"] = "冷却/持续时间计量条在冷却/持续时间刚开始时的颜色"
L["COLOR_COA"] = "倒数中,计时器隐藏,一直显示"
L["COLOR_COA_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已禁用
%q设置为%q]=]
L["COLOR_COLOR"] = "颜色"
L["COLOR_COS"] = "倒数中,计时器隐藏,有时显示"
L["COLOR_COS_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已禁用
%q没有设置为%q]=]
L["COLOR_CTA"] = "倒数中,计时器显示,一直显示"
L["COLOR_CTA_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已启用
%q设置为%q]=]
L["COLOR_CTS"] = "倒数中,计时器显示,有时显示"
L["COLOR_CTS_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已启用
%q没有设置为%q]=]
L["COLOR_DEFAULT"] = "*全局颜色*"
L["COLOR_DESATURATE"] = "灰色调"
L["COLOR_DESATURATE_DESC"] = "勾选此项图标中相应的颜色将使用灰色调.(注意:需要先勾选颜色类型的'使用'选项)"
L["COLOR_HEADER"] = [=[下列这些颜色设置将使用在所有 %s 的图标上,在它们的选项 %q 已勾选的情况下.

纯白色不会对材质造成任何改变. 纯黑色会使材质完全变黑.所有介于黑白两者之间的灰色调及其他颜色全部都会对图标进行着色.]=]
L["COLOR_HEADER_DEFAULT"] = [=[在图标类型没有单独使用颜色设置的时候将使用这些颜色设置.

纯白色不会对材质造成任何改变. 纯黑色会使材质完全变黑.所有介于黑白两者之间的灰色调及其他颜色全部都会对图标进行着色.]=]
L["COLOR_NA"] = "已结束,一直显示"
L["COLOR_NA_DESC"] = [=[图标在何时着色:

计时器已结束(可用/缺少时)
%q设置为%q]=]
L["COLOR_NS"] = "已结束,有时显示"
L["COLOR_NS_DESC"] = [=[图标在何时着色:

计时器已结束(可用/缺少时)
%q没有设置为%q]=]
L["COLOR_OOM"] = "魔法值不足"
L["COLOR_OOM_DESC"] = "当你缺少施放技能所需能量时图标的颜色."
L["COLOR_OOR"] = "超出距离"
L["COLOR_OOR_DESC"] = "当你不在技能范围内时图标的颜色."
L["COLOR_OORM"] = "超出距离&魔法值不足"
L["COLOR_OORM_DESC"] = "当你缺少施放技能所需的能量 同时 不在技能范围内时图标的颜色."
L["COLOR_OVERRIDEDEFAULT"] = "使用"
L["COLOR_OVERRIDEDEFAULT_DESC"] = "勾选此项将使用该设置覆盖*全局颜色*."
L["COLOR_RESET_DESC"] = "重置设置到默认值"
L["COMPARISON"] = "比较"
L["CONDITIONALPHA"] = "持续时间/叠加/条件未通过时"
L["CONDITIONALPHA_CONDITIONICON"] = "持续时间未通过时"
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "该透明度设置用于持续时间的要求无法得到满足时.如果在其它两个透明度的设置下图标已经隐藏,此选项将被忽略."
L["CONDITIONALPHA_DESC"] = "该设置使用在条件未通过或持续时间/叠加数量无法得到满足时.如果在其它两个透明度的设置下图标已经隐藏,此选项将被忽略."
L["CONDITIONORMETA_CHECKINGINVALID"] = "警告!分组%d,图标%d正在检测一个无效的图标(分组%d,图标%d)"
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "警告!分组 %d 正在检测一个无效的图标(分组 %d, 图标 %d)"
L["CONDITIONPANEL_ABSOLUTE"] = "当前"
L["CONDITIONPANEL_ADD"] = "增加条件"
L["CONDITIONPANEL_ALIVE"] = "单位存活"
L["CONDITIONPANEL_ALIVE_DESC"] = "这个条件会检测指定单位的存活情况."
L["CONDITIONPANEL_ALTPOWER"] = "特殊能量"
L["CONDITIONPANEL_ALTPOWER_DESC"] = [=[这是大地的裂变某些首领战遇到的特殊能量,像是古加尔的腐化值跟艾卓曼德斯的音波值.
]=]
L["CONDITIONPANEL_AND"] = "同时"
L["CONDITIONPANEL_ANDOR"] = "同时/或者"
L["CONDITIONPANEL_ANDOR_DESC"] = "点击切换逻辑运算符 同时/或者(And/Or)"
L["CONDITIONPANEL_AUTOCAST"] = "宠物自动施法"
L["CONDITIONPANEL_CASTTOMATCH"] = "用于匹配的法术"
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = [=[输入一个法术名称使该条件只在施放的法术名称跟输入的法术名称完全匹配时才可通过.

你可以保留空白来检测任意的法术施放/引导法术(不包括瞬发法术).]=]
L["CONDITIONPANEL_CLASS"] = "单位职业"
L["CONDITIONPANEL_CLASSIFICATION"] = "单位分类"
L["CONDITIONPANEL_COMBAT"] = "单位在战斗中"
L["CONDITIONPANEL_COMBO"] = "连击点数"
L["CONDITIONPANEL_DEFAULT"] = "选择条件类型..."
L["CONDITIONPANEL_ECLIPSE_DESC"] = [=[蚀星蔽月的范围是-100(月蚀)到100(日蚀)
如果你想在月蚀能量80時显示图标就輸入-80

说明:蚀星蔽月是台服的翻译,大陆的翻译叫月蚀,这样不容易区分这个月蚀所对应的日蚀/月蚀,所以这里的说明文字直接用台服的翻译.]=]
L["CONDITIONPANEL_EQUALS"] = "等于"
L["CONDITIONPANEL_EXISTS"] = "单位存在"
L["CONDITIONPANEL_GREATER"] = "大于"
L["CONDITIONPANEL_GREATEREQUAL"] = "大于或等于"
L["CONDITIONPANEL_GROUPTYPE"] = "组队类型"
L["CONDITIONPANEL_ICON"] = "图标显示"
L["CONDITIONPANEL_ICON_DESC"] = [=[此条件检测指定图标的显示状态或隐藏状态.

如果你不想显示那个被检测的图标,请在被检测图标的图标编辑器勾选 %q.

即使条件设置为否,同样会强制检测图标的显示情况.]=]
L["CONDITIONPANEL_ICON_HIDDEN"] = "隐藏"
L["CONDITIONPANEL_ICON_SHOWN"] = "显示"
L["CONDITIONPANEL_INSTANCETYPE"] = "副本类型"
L["CONDITIONPANEL_INTERRUPTIBLE"] = "可打断"
L["CONDITIONPANEL_ITEMRANGE"] = "单位在物品范围内"
L["CONDITIONPANEL_LESS"] = "小于"
L["CONDITIONPANEL_LESSEQUAL"] = "小于或等于"
L["CONDITIONPANEL_LEVEL"] = "单位等级"
L["CONDITIONPANEL_MANAUSABLE"] = "法术可用(魔法值/能量/等是否够用.)"
L["CONDITIONPANEL_MAX"] = "最大"
L["CONDITIONPANEL_MOUNTED"] = "在坐骑上"
L["CONDITIONPANEL_NAME"] = "单位名字"
L["CONDITIONPANEL_NAMETOMATCH"] = "用于匹配的名字"
L["CONDITIONPANEL_NAMETOOLTIP"] = "你可以在每个名字后面加上分号(;)以便输入多个需要匹配的名字. 其中任何一个名字匹配时此条件都会通过."
L["CONDITIONPANEL_NOTEQUAL"] = "不等于"
L["CONDITIONPANEL_OPERATOR"] = "运算"
L["CONDITIONPANEL_OR"] = "或者"
L["CONDITIONPANEL_PETMODE"] = "宠物攻击模式"
L["CONDITIONPANEL_PETTREE"] = "宠物天赋树"
L["CONDITIONPANEL_POWER"] = "基本资源(能量类型)"
L["CONDITIONPANEL_POWER_DESC"] = "如果单位是猫形态的德鲁伊将检测能量值,如果是战士则检测怒气,等等"
L["CONDITIONPANEL_PVPFLAG"] = "单位PVP开启状态"
L["CONDITIONPANEL_RAIDICON"] = "单位团队标记"
L["CONDITIONPANEL_REMOVE"] = "移除此条件"
L["CONDITIONPANEL_RESTING"] = "休息状态"
L["CONDITIONPANEL_ROLE"] = "单位角色类型"
L["CONDITIONPANEL_RUNES_DESC"] = [=[使用此条件类型让图标只在选择的符文可用时显示。
每个符文都可以复选。一个复选标记会要求符文是可用的，一个'X'会要求符文是不可用的，没标记将会忽略这个符文。
第二行符文为上面每个符文所对应的死亡符文。]=]
L["CONDITIONPANEL_SPELLRANGE"] = "单位在法术范围内"
L["CONDITIONPANEL_SWIMMING"] = "在游泳中"
L["CONDITIONPANEL_THREAT_RAW"] = "单位威胁值 - 原始"
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [=[此条件用来检测你对一个单位的原始威胁值百分比.

近战玩家仇恨失控(OT)的威胁值为110%
远程玩家仇恨失控(OT)的威胁值为130%]=]
L["CONDITIONPANEL_THREAT_SCALED"] = "单位威胁值 - 比例"
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [=[此条件用来检测你对一个单位的威胁值百分比比例.

100%表示你正在坦这个单位.]=]
L["CONDITIONPANEL_TRACKING"] = "追踪"
L["CONDITIONPANEL_TYPE"] = "类型"
L["CONDITIONPANEL_UNIT"] = "单位"
L["CONDITIONPANEL_UNIT_DESC"] = [=[在此输入需要监视的单位,此单位能从下拉列表插入到右边,或者您是位高端玩家可以自行输入需要监视的单位.
可使用标准单位(例如:player,target,mouseover,等),或者友好玩家的名字(例如: %s, Cybeloras,百战好哥哥,等)
PS:上面的标准单位不是没有翻译,宏里可以使用的单位都可以使用.]=]
L["CONDITIONPANEL_UNITDROPDOWN_DESC"] = [=[您可以从此菜单选择单位插入到编辑框中.
单位的结尾'|cFFFF0000#|r'需要替换为单位相对应的数字.
例如更改'raid|cFFFF0000#|r'为'raid25'检测第25个团队成员.

注意：所有条件只允许检测一个单位.]=]
L["CONDITIONPANEL_UNITISUNIT"] = "单位比较"
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "此条件在两个文本框输入的单位为同一角色时通过.(例子:文本框1为'targettarget',文本框2为'player',当'目标的目标'为'玩家'时则此条件通过. )"
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "在此文本框输入需要与所指定的第一单位进行比较的第二单位."
L["CONDITIONPANEL_VALUEN"] = "取值"
L["CONDITIONPANEL_VEHICLE"] = "单位控制载具"
L["CONDITIONS"] = "条件"
L["CONDITION_TIMERS_FAIL_DESC"] = [=[设置条件无法通过以后图标计时器的持续时间

(译者注:图标在条件每次通过/无法通过后都会重新计时,另外在默认的情况下图标的显示只会根据条件通过情况来改变,设定的持续时间不会影响到图标的显示情况,不会在设置的持续时间倒数结束后隐藏图标,如果想要图标在计时结束后隐藏,需要勾选'仅在计时器作用时显示',这是4.5.3版本新加入的功能.)]=]
L["CONDITION_TIMERS_HEADER"] = "计时器"
L["CONDITION_TIMERS_SUCCEED_DESC"] = [=[设置条件成功通过以后图标计时器的持续时间

(译者注:图标在条件每次通过/无法通过后都会重新计时,另外在默认的情况下图标的显示只会根据条件通过情况来改变,设定的持续时间不会影响到图标的显示情况,不会在设置的持续时间倒数结束后隐藏图标,如果想要图标在计时结束后隐藏,需要勾选'仅在计时器作用时显示',这是4.5.3版本新加入的功能.)]=]
L["CONFIGMODE"] = "TellMeWhen正处于设置模式. 在离开设置模式之前,图标无法正常使用. 输入'/tellmewhen'或'/tmw'可以开启或关闭设置模式."
L["CONFIGMODE_EXIT"] = "退出设置模式"
L["CONFIGMODE_NEVERSHOW"] = "不再显示此信息"
L["CONFIRMOVERWRITE"] = "确认覆盖"
L["COPYGROUP"] = "复制分组"
L["COPYPOSSCALE"] = "复制位置/比例"
L["CrowdControl"] = "控场技能"
L["Curse"] = "诅咒"
L["DamageBuffs"] = "信春哥(伤害性增益)"
L["DAMAGER"] = "伤害输出"
L["DEBUFFTOCHECK"] = "要检测的减益"
L["DEBUFFTOCOMP1"] = "进行比较的第一个减益"
L["DEBUFFTOCOMP2"] = "进行比较的第二个减益"
L["DEFAULT"] = "默认值"
L["DefensiveBuffs"] = "信春哥(防御性增益)"
L["DESCENDING"] = "降序"
L["DISABLED"] = "已停用"
L["Disarmed"] = "被缴械"
L["Disease"] = "疾病"
L["Disoriented"] = "被魅惑"
L["DR-Banish"] = "放逐术"
L["DR-ControlledRoot"] = "控制定身"
L["DR-ControlledStun"] = "控制昏迷"
L["DR-Cyclone"] = "旋风"
L["DR-Disarm"] = "缴械"
L["DR-Disorient"] = "迷惑/其他"
L["DR-DragonsBreath"] = "龙息术"
L["DR-Entrapment"] = "诱捕"
L["DR-Fear"] = "恐惧"
L["DR-Horrify"] = "惊骇"
L["DR-MindControl"] = "精神控制"
L["DROPDOWN_UNIT_DESC"] = [=[您可以从这个菜单选择单位插入到编辑框中。
单位结尾'|cFFFF0000#|r'需要替换为单位相对应的数字，或者输入某个范围的数字，像是1-10。
例如更改 'raid|cFFFF0000#|r'为'raid25'检测第25个团队成员，或者把它改成'raid1-25'检测前25个团队成员。

需要更多关于单位的信息，请访问http://www.wowpedia.org/UnitId]=]
L["DR-RandomRoot"] = "随机定身"
L["DR-RandomStun"] = "随机昏迷"
L["DR-Scatter"] = "驱散射击"
L["DR-Silence"] = "沉默"
L["DR-Taunt"] = "嘲讽"
L["DURATION"] = "持续时间"
L["DURATIONPANEL_TITLE"] = "持续时间"
L["EARTH"] = "大地图腾"
L["ECLIPSE_DIRECTION"] = "月蚀方向"
L["elite"] = "精英"
L["ENABLINGOPT"] = "TellMeWhen设置已禁用.重新启用中...."
L["Enraged"] = "激怒"
L["ERROR_ANCHORSELF"] = "%s尝试附着于它自己, 所以TellMeWhen会重置它的附着位置到屏幕中间以防止出现严重的错误."
L["ERROR_MISSINGFILE"] = "TellMeWhen需要在重开魔兽世界之后才能正常使用%s (原因:无法找到 %s ). 你要马上重开魔兽世界吗?"
L["ERROR_MISSINGFILE_NOREQ"] = "TellMeWhen需要在重开魔兽世界之后才能完全正常使用%s (原因:无法找到 %s ). 你要马上重开魔兽世界吗?"
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "仅在条件刚通过时"
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "除非上面设置的条件刚刚成功通过,否则阻止事件的触发."
L["EVENTS_SETTINGS_GLOBAL_DESC"] = "注意:此事件设置将影响到包括'音效'和'文字输出'在内的所有与该设置相关的输出事件."
L["EVENTS_SETTINGS_HEADER"] = "事件设置"
L["EVENTS_SETTINGS_ONLYSHOWN"] = "仅在图标显示时触发"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "勾选此项防止图标在没有显示时触发相关事件."
L["EVENTS_SETTINGS_PASSINGCNDT"] = "仅在条件通过时触发:"
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "除非下面设置的条件成功通过,否则阻止事件的触发."
L["EVENTS_SETTINGS_PASSTHROUGH"] = "允许触发其他事件"
L["EVENTS_SETTINGS_PASSTHROUGH_DESC"] = [=[允许在触发该事件后去触发另一个事件,如果取消勾选,在该事件触发并输出了文字/音效之后,图标不再处理同时触发的其它任何事件.

可以有例外,详情请参阅个别事件的描述.]=]
L["EXPORT_f"] = "导出 %s"
L["EXPORT_HEADING"] = "导出"
L["EXPORT_SPECIALDESC"] = "另一TellMeWhen用户需要安装4.6.0+的版本才可以导入整个分组或整个配置文件."
L["EXPORT_TOCOMM"] = "到玩家"
L["EXPORT_TOCOMM_DESC"] = "输入一个玩家的名字到编辑框同时选择此选项来发送数据给他们.他们必须是你能密语的某人(同阵营,同服务器,在线),同时他们必须已经安装版本为4.0.0+的TellMeWhen."
L["EXPORT_TOSTRING"] = "到字符串"
L["EXPORT_TOSTRING_DESC"] = "包含必要数据的字符串将导出到编辑框里,按下CTRL+C复制它,然后到任何你想分享的地方贴上它."
L["FALSE"] = "否"
L["Feared"] = "被恐惧"
L["fGROUP"] = "分组: %s"
L["fICON"] = "图标: %s"
L["FIRE"] = "火焰图腾"
L["FONTCOLOR"] = "文字颜色"
L["FONTSIZE"] = "字体大小"
L["fPROFILE"] = "配置文件: %s"
L["FROMNEWERVERSION"] = "你导入的数据是版本较新的TellMeWhen所创建的,某些设置在你更新至最新版本之前可能无法正常使用."
L["GCD"] = "公共冷却"
L["GCD_ACTIVE"] = "公共CD作用中"
L["GENERIC_NUMREQ_CHECK_DESC"] = "勾选以启用并配置%s"
L["GROUPADDONSETTINGS"] = "分组设置"
L["GROUPCONDITIONS"] = "分组条件"
L["GROUPICON"] = "分组:%s ，图标:%s"
L["HEALER"] = "治疗"
L["Heals"] = "玩家治疗法术"
L["HELP_EXPORT_DOCOPY_MAC"] = "按下|cff7fffffCMD+C|r复制"
L["HELP_EXPORT_DOCOPY_WIN"] = "按下|cff7fffffCTRL+C|r复制"
L["HELP_FIRSTUCD"] = [=[这是你第一次使用一个采取特定的持续时间语法的图标类型!
在添加法术到某些图标类型的 %q 编辑框时,必须使用下列语法在法术后面指定它们的持续时间:

法术:持续时间

例如:

"%s: 120"
"%s: 10;%s: 24"
"%s: 180"
"%s: 3:00"
"62618: 3:00"

用建议列表插入条目时会自动添加在鼠标提示信息中显示的时间(注:仅支持提示信息中显示的冷却时间).]=]
L["HELP_ICD_NATURESGRACE"] = [=[您是否尝试检测%s的内置冷却?

建议您将图标类型更改为 %q , 可以在日蚀或月蚀触发之后正确重置自然之赐的冷却时间.]=]
L["HELP_IMPORT_CURRENTPROFILE"] = [=[尝试在这个配置文件中移动或复制一个图标到另外一个图标栏位?

你可以轻松的做到这一点,使用鼠标右键点击图标并拖拽它到另外一个图标栏位(这个过程需要按下鼠标右键不放开). 当你放开鼠标右键时,会出现一个有很多选项的选单.

尝试拖拽一个图标到整合图标,其他分组,或在你屏幕上的其他框架以获取其他相应的选项.]=]
L["HELP_MISSINGDURS"] = [=[以下法术缺少持续时间:

%s

请使用下列语法添加持续时间:

法术:持续时间

例如"%s: 10"

用建议列表插入条目时会自动添加在鼠标提示信息中显示的时间(注:仅支持提示信息中显示的冷却时间).]=]
L["HELP_MS_NOFOUND"] = [=[无法在动作条上找到技能 %q.

请确保那个技能在你的动作条上,并且它是处于默认状态,必须要注意的是出现在动作条上的技能不能是一个宏,而是应该直接把技能放到你的动作条上.否则此图标可能无法正常使用.

上述默认状态指没有施放该技能使其出现第二个状态.]=]
L["HELP_NOUNIT"] = "你必须输入一个单位!"
L["HELP_NOUNITS"] = "你至少需要输入一个单位!"
L["HELP_POCKETWATCH"] = [=[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t -- 关于怀表材质

此材质用于第一个检测到的有效法术在你的法术书中不存在时.

正确的材质将会在你施放过一次或者见到过一次该法术之后使用.

若要显示正确的材质,请把第一个被检测的法术名称更改为法术ID.你可以轻松的做到这一点,你只需要点击名称编辑框中的法术,再根据之后出现的建议列表中显示的正确的以及相对应的法术上点击鼠标右键即可.

(这里的法术指排在首位的法术,当你的鼠标移动到建议列表的某个法术上时,在提示信息中可以看到更为具体的鼠标左右键插入法术ID或法术名称的方法.)]=]
L["ICON"] = "图标"
L["ICONALPHAPANEL_FAKEHIDDEN"] = "始终隐藏"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = "使该图标一直被隐藏,但图标依然会处理并执行音效跟文字输出,而且仍然可以让包含该图标的条件或者整合图标进行检测."
L["ICONGROUP"] = "图标: %s (分组: %s)"
L["ICONMENU_ABSENT"] = "不存在"
L["ICONMENU_ADDMETA"] = "添加到'整合图标'"
L["ICONMENU_ALPHA"] = "透明度"
L["ICONMENU_ALWAYS"] = "一直显示"
L["ICONMENU_ANCHORTO"] = "附着到 %s"
L["ICONMENU_ANCHORTO_DESC"] = [=[附着%s到%s,无论%s如何移动,%s都会跟随它一起移动.

分组选项中有更为详细的附着设置.]=]
L["ICONMENU_ANCHORTO_UIPARENT"] = "重置附着"
L["ICONMENU_ANCHORTO_UIPARENT_DESC"] = [=[让%s重新附着到你的屏幕(UIParent).它目前附着到%s.

分组选项中有更为详细的附着设置.

分组选项中有更为详细的附着设置.]=]
L["ICONMENU_APPENDCONDT"] = "添加到'图标显示'条件"
L["ICONMENU_BAROFFS"] = [=[此数值将会添加到计量条以便用来调整它的偏移值.

一些有用的例子:
当你开始施法时防止一个增益消失的自订指示器,或者用来指示某个法术施放所需能量的同时还剩多少时间可以打断施法.]=]
L["ICONMENU_BINDTEXT_DESC"] = [=[在此编辑框中的任意文字将以动作条上显示的按键绑定文字的方式显示在图标上.这并非设定TellMeWhen图标的按键绑定!它只是一个显示在图标上的文字提示的视觉效果.在本组的'分组设置'中可以更改此文字的设置.

自定义显示文字可以使用下列的单位变量:

"%u" - 当前被检测的单位的名字
"%s" - ​​当前被检测的法术/物品/等的名字]=]
L["ICONMENU_BOTH"] = "任意一种"
L["ICONMENU_BUFF"] = "增益"
L["ICONMENU_BUFFDEBUFF"] = "增益/减益"
L["ICONMENU_BUFFDEBUFF_DESC"] = "检测增益或减益."
L["ICONMENU_BUFFTYPE"] = "增益或减益"
L["ICONMENU_CAST"] = "法术施放"
L["ICONMENU_CAST_DESC"] = "检测非瞬发施法跟引导法术."
L["ICONMENU_CASTS"] = "法术施放"
L["ICONMENU_CASTSHOWWHEN"] = "何时显示法术施放"
L["ICONMENU_CHECKNEXT"] = "检测子元(用于列表中包含整合图标)"
L["ICONMENU_CHECKNEXT_DESC"] = [=[选中此框该图标将检测添加在列表中的任意整合图标所包含的全部图标,它可能是任何级别的检测.

此外,该图标不会显示已经在另一个整合图标显示的任何分组/图标ID接近1的图标.]=]
L["ICONMENU_CHECKREFRESH"] = "法术刷新侦测"
L["ICONMENU_CHECKREFRESH_DESC"] = [=[暴雪的战斗记录在涉及法术刷新和恐惧（或者某些在造成一定伤害量后才会中断的法术）存在严重缺陷，战斗记录会认为法术在造成伤害时已经刷新，尽管事实上并非如此。

取消此选项以便停用法术刷新侦测，注意：正常的刷新也将被忽略。

如果你检测的递减在造成一定伤害量后不会中断的话建议保留此选项。]=]
L["ICONMENU_CHOOSENAME"] = "选择用于检测的名称/ID"
L["ICONMENU_CHOOSENAME_CNDTIC"] = "选择 名称/ID/材质路径"
L["ICONMENU_CHOOSENAME_ITEMSLOT"] = "选择用于检测的 名称 / ID / 装备栏编号(%d-%d)"
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[输入你想要此图标监视的 名称/ID/装备栏编号. 你可以利用分号添加多个条目(名称/ID/装备栏编号的任意组合).

装备栏编号是已装备物品所在栏位的编号索引.如果你更换了那个装备栏的已装备物品,将不会影响图标的正常使用并且在图标上会立刻反映出来.

你可以按住Shift再按鼠标左键点选物品/聊天连结 或者拖曳物品添加此编辑框中.]=]
L["ICONMENU_CHOOSENAME_MULTISTATE"] = "选择用于检测的 名称/ID"
L["ICONMENU_CHOOSENAME_ORBLANK"] = "或者保留空白检测所有"
L["ICONMENU_CHOOSENAME_WPNENCH"] = "选择用于检测的暂时性武器附魔"
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[输入你想要此图标监视的暂时性武器附魔的名称. 你可以利用分号(;)添加多个条目.

|cFFFF5959重要提示|r: 附魔名称必须使用在暂时性武器附魔激活时出现在武器的提示信息中的那个名称(例如:'磨快（+6伤害）', 而不是'坚固的磨刀石').

注:大陆版魔兽世界中的部分标点符号用的是全角标点,在这里需要使用的就是全角括号.]=]
L["ICONMENU_CNDTIC"] = "条件图标"
L["ICONMENU_CNDTIC_DESC"] = "检测条件的状态."
L["ICONMENU_CNDTSHOWWHEN"] = "当条件怎样时显示"
L["ICONMENU_COMPONENTICONS"] = "组件图标&分组"
L["ICONMENU_COOLDOWNCHECK"] = "冷却检测"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "勾选此项启用当可用技能在冷却中时视为不可用."
L["ICONMENU_COOLDOWNTYPE"] = "冷却类型"
L["ICONMENU_COPYHERE"] = "复制到此"
L["ICONMENU_CUSTOMTEX"] = "自定义图标材质"
L["ICONMENU_CUSTOMTEX_DESC"] = "如果你要更改此图标​​显示的材质, 输入你想使用的材质的法术名称或ID. 你也可以输入一个材质路径, 例如'Interface/Icons/spell_nature_healingtouch', 假如材质路径为'Interface/Icons'可以只输入'spell_nature_healingtouch'."
L["ICONMENU_DEBUFF"] = "减益"
L["ICONMENU_DISPEL"] = "驱散类型"
L["ICONMENU_DONTREFRESH"] = "不刷新"
L["ICONMENU_DONTREFRESH_DESC"] = [=[勾选此项当效果触发时它仍然在倒计时则不重置冷却时间.
在类似法师的早霜等天赋会用到.]=]
L["ICONMENU_DR"] = "递减"
L["ICONMENU_DRABSENT"] = "未递减"
L["ICONMENU_DR_DESC"] = "检测递减时间跟递减程度."
L["ICONMENU_DRPRESENT"] = "已递减"
L["ICONMENU_DRS"] = "递减"
L["ICONMENU_DURATION_MAX_DESC"] = "允许图标显示的最大持续时间,高于此数值图标将被隐藏."
L["ICONMENU_DURATION_MIN_DESC"] = "显示图标所需的最小持续时间,低于此数值图标将被隐藏."
L["ICONMENU_ENABLE"] = "启用图标"
L["ICONMENU_FAIL"] = "无法通过时"
L["ICONMENU_FOCUS"] = "焦点目标"
L["ICONMENU_FOCUSTARGET"] = "焦点目标的目标"
L["ICONMENU_FRIEND"] = "友好单位"
L["ICONMENU_GHOUL"] = "非永久食尸鬼"
L["ICONMENU_GHOUL_DESC"] = "仅用于在你没有加 %s 天赋时,检测你的食尸鬼的剩余时间."
L["ICONMENU_HIDEUNEQUIPPED"] = "武器栏为空时隐藏"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "勾选此项在检测的武器栏没有装备武器时强制隐藏图标"
L["ICONMENU_HOSTILE"] = "敌对单位"
L["ICONMENU_ICD"] = "内置冷却/法术持续时间"
L["ICONMENU_ICDAURA_DESC"] = [=[选择此项,如果内置冷却在你获得一个增益/减益后开始(包括触发)或是在充能效果使你恢复法力值/怒气/等之后开始.

你需要在 %q 编辑框中输入你获得的使你触发内置冷却的增益/減益的名称/ID或者是充能效果的名称/ID

(请查看你的战斗记录或者利用插件来确认法术名称/ID)]=]
L["ICONMENU_ICDBDE"] = "增益/减益/充能/召唤"
L["ICONMENU_ICD_DESC"] = [=[检测一个触发效果或与其类似效果的冷却.

|cFFFF5959重要提示|r: 关于如何检测每个类型的内置冷却请参阅在 %q 下方选项的提示信息.]=]
L["ICONMENU_ICDTYPE"] = "何时触发"
L["ICONMENU_ICONUNIT"] = "<图标单位>"
L["ICONMENU_ICONUNIT_DESC"] = "插入单位变量\"%u\",它将检测图标当前正在检测的所有单位."
L["ICONMENU_IGNORENOMANA"] = "忽略能量不足"
L["ICONMENU_IGNORENOMANA_DESC"] = [=[勾选此项当一个技能仅仅是因为能量不足而不可用时视该技能为可用.

对于像是%s 或者 %s这类技能很实用.]=]
L["ICONMENU_IGNORERUNES"] = "忽略符文"
L["ICONMENU_IGNORERUNES_DESC"] = "勾选此项,如果阻碍技能冷却的只是一个符文冷却（或公共冷却）时视为技能冷却可用."
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "\"忽略符文\"必须在\"冷却检测\"已勾选后才可使用."
L["ICONMENU_INVERTBARS"] = "反转计量条"
L["ICONMENU_INVERTBARS_DESC"] = "勾选此项在能量值足以施放法术 或者 持续时间到0时显示为完全填充的计量条."
L["ICONMENU_ITEMCOOLDOWN"] = "物品冷却"
L["ICONMENU_ITEMCOOLDOWN_DESC"] = "检测物品冷却."
L["ICONMENU_MANACHECK"] = "能量检测"
L["ICONMENU_MANACHECK_DESC"] = [=[勾选此项启用当你魔法值/怒气/符能等等不足时改变图标颜色(或视为不可用).

注:除非特別说明,本插件中的能量一般是指法术施放所需的法力/怒气/符能/集中值等等,并非指盗贼/野德鲁伊的能量值.]=]
L["ICONMENU_META"] = "整合图标"
L["ICONMENU_META_DESC"] = [=[组合多个图标到一个图标.

在整合图标中被检测的那些图标即使设置为 %q 在可以显示时同样会显示.]=]
L["ICONMENU_MOUSEOVER"] = "鼠标悬停目标"
L["ICONMENU_MOUSEOVERTARGET"] = "鼠标悬停目标的目标"
L["ICONMENU_MOVEHERE"] = "移动到此"
L["ICONMENU_MULTISTATECD"] = "多重状态技能"
L["ICONMENU_MULTISTATECD_DESC"] = [=[检测一个多重状态的技能.

此选项应当在你想要检测像是 %s 或 %s 这些多重状态/材质的冷却时间时使用.]=]
L["ICONMENU_MUSHROOMS"] = "%s"
L["ICONMENU_MUSHROOMS_DESC"] = "检测%s."
L["ICONMENU_OFFS"] = "偏移"
L["ICONMENU_ONLYBAGS"] = "只在背包中存在时"
L["ICONMENU_ONLYBAGS_DESC"] = "勾选此项当物品在背包中(或者已装备)时显示图标,如果启用'已装备的物品',此选项会被强制启用。"
L["ICONMENU_ONLYEQPPD"] = "只在已装备时"
L["ICONMENU_ONLYEQPPD_DESC"] = "勾选此项让图标只在物品已装备时显示."
L["ICONMENU_ONLYIFCOUNTING"] = "仅在计时器作用时显示"
L["ICONMENU_ONLYIFCOUNTING_DESC"] = "勾选此项使图标仅在当前有一个作用中的计时器正在运行并且它的持续时间大于0时显示."
L["ICONMENU_ONLYINTERRUPTIBLE"] = "仅可打断"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "仅在施法可打断时显示."
L["ICONMENU_ONLYMINE"] = "仅检测自己施放的"
L["ICONMENU_ONLYMINE_DESC"] = "勾选此项让该图标只显示你施放的增益或减益"
L["ICONMENU_ONLYSEEN"] = "仅显示施放过的法术"
L["ICONMENU_ONLYSEEN_DESC"] = "选择此项可以让图标只显示某单位至少施放过一次的法术冷却.如果你在同一个图标检测不同职业的法术那么应该勾上它."
L["ICONMENU_OVERLAYBARHEADER"] = "覆盖计量条"
L["ICONMENU_PETTARGET"] = "宠物的目标"
L["ICONMENU_PRESENT"] = "存在"
L["ICONMENU_RANGECHECK"] = "距离检测"
L["ICONMENU_RANGECHECK_DESC"] = "勾选此项启用当你超出范围时改变图标颜色(或视为不可用)"
L["ICONMENU_REACT"] = "单位反应"
L["ICONMENU_REACTIVE"] = "触发性技能"
L["ICONMENU_REACTIVE_DESC"] = [=[检测触发性技能的可用情况.

触发性的技能指类似 %s, %s 和 %s 这些只能在某种特定条件下使用的技能.]=]
L["ICONMENU_RUNES"] = "符文冷却"
L["ICONMENU_RUNES_DESC"] = "检测符文冷却."
L["ICONMENU_SHOWCBAR_DESC"] = "将会在跟图标重叠的下半部份显示剩余的冷却/持续时间的计量条(或是在'反转计量条'启用的情况下显示已用的时间)"
L["ICONMENU_SHOWCBARN"] = "计时条"
L["ICONMENU_SHOWPBAR_DESC"] = [=[将会在跟图标重叠的上半部份方显示你施放此法术还需多少能量的能量条(或是在'反转计量条'启用的情况下显示当前的能量).

注:这个能量可以是盗贼的能量,战士的怒气,猎人的集中值,其他职业的法力值等等.]=]
L["ICONMENU_SHOWPBARN"] = "能量条"
L["ICONMENU_SHOWSTACKS"] = "显示叠加数量"
L["ICONMENU_SHOWSTACKS_DESC"] = "勾选此项显示物品的叠加数量并启用叠加数量条件."
L["ICONMENU_SHOWTIMER"] = "显示计时器"
L["ICONMENU_SHOWTIMER_DESC"] = "勾选此项让该图标的冷却时钟动画在可用时显示.(注:此选项仅影响图标的时钟动画,就是技能冷却时的那个转圈效果,不包括数字在内哦.)"
L["ICONMENU_SHOWTIMERTEXT"] = "显示计时器数字"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [=[勾选此项在图标上显示剩余冷却时间或持续时间的数字.

需要已安裝OmniCC或其他冷却计时插件才可使用(注:某些冷却计时插件可能不支持此选项).]=]
L["ICONMENU_SHOWTTTEXT"] = "显示变量文字"
L["ICONMENU_SHOWTTTEXT_DESC"] = [=[勾选此项在叠加数量文字的位置上显示从法术效果的提示信息中找到的第一个变量(数字).比如用此监视伤害护盾的剩余吸收量等等.

数字是由暴雪API所提供,跟你在法术效果的提示信息中看到的数字可能会不同(像是服务器已经在线修正,客户端依然显示错误的数字这种情况),在大多数情况下都能显示正确的数字.]=]
L["ICONMENU_SHOWWHEN"] = "何时显示图标"
L["ICONMENU_SORTASC"] = "持续时间升序"
L["ICONMENU_SORTASC_DESC"] = "勾选此项优先显示持续时间最低的法术."
L["ICONMENU_SORTDESC"] = "持续时间降序"
L["ICONMENU_SORTDESC_DESC"] = "勾选该项优先显示持续时间最高的法术."
L["ICONMENU_SPELL"] = "法术或技能"
L["ICONMENU_SPELLCAST_COMPLETE"] = "施法结束/瞬发"
L["ICONMENU_SPELLCAST_COMPLETE_DESC"] = [=[选择此项如果内置冷却需要在你施法结束后才开始,或是在你施放一个瞬发法术后开始.

你需要在 %q 编辑框中输入那个触发内置冷却的法术名称或ID.]=]
L["ICONMENU_SPELLCAST_START"] = "施法开始"
L["ICONMENU_SPELLCAST_START_DESC"] = [=[选择此项如果内置冷却是在开始施法后就触发.

你需要在 %q 编辑框中输入那个触发内置冷却的法术名称或ID.]=]
L["ICONMENU_SPELLCOOLDOWN"] = "法术冷却"
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "检测在你法术书中的那些法术的冷却"
L["ICONMENU_SPLIT"] = "拆分成新的分组"
L["ICONMENU_SPLIT_DESC"] = "创建一个新的分组并将这个图标移动到上面. 原分组中的许多设置会保留到新的分组."
L["ICONMENU_STACKS_MAX_DESC"] = "允许图标显示的最大叠加数量,高于此数值图标将被隐藏."
L["ICONMENU_STACKS_MIN_DESC"] = "显示图标所需的最低叠加数量,低于此数值图标将被隐藏."
L["ICONMENU_STEALABLE"] = "仅可法术吸取"
L["ICONMENU_STEALABLE_DESC"] = "勾选此项仅显示能被“法术吸取”的增益，非常适合跟驱散类型中的魔法搭配使用。"
L["ICONMENU_SUCCEED"] = "成功通过时"
L["ICONMENU_SWAPWITH"] = "交换位置"
L["ICONMENU_TARGETTARGET"] = "目标的目标"
L["ICONMENU_TOTEM"] = "图腾"
L["ICONMENU_TOTEM_DESC"] = "检测你的图腾."
L["ICONMENU_TYPE"] = "图标类型"
L["ICONMENU_UNITCOOLDOWN"] = "单位冷却"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[检测其他单位的冷却.

%s可以使用 %q 作为名称来检测.

注:玩家也可以作为被检测的单位.]=]
L["ICONMENU_UNIT_DESC"] = [=[在此框输入需要监视的单位,此单位能从下拉列表插入到右边,或者你是一位高端玩家可以自行输入需要监视的单位.
多个单位请用分号分隔开(;),可使用标准单位(例如:player,target,mouseover等等可用在宏里的单位),或者友好玩家的名字(像是%s,Cybeloras,百战好哥哥等.)

需要更多关于单位的资讯,请访问http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNITS"] = "单位"
L["ICONMENU_UNITSTOWATCH"] = "监视的单位"
L["ICONMENU_UNUSABLE"] = "不可用"
L["ICONMENU_USABLE"] = "可用"
L["ICONMENU_USEACTIVATIONOVERLAY"] = "检测激活边框"
L["ICONMENU_USEACTIVATIONOVERLAY_DESC"] = "检测系统默认提示技能可用时的黄色发光边框."
L["ICONMENU_VEHICLE"] = "载具"
L["ICONMENU_WPNENCHANT"] = "暂时性武器附魔"
L["ICONMENU_WPNENCHANT_DESC"] = "检测暂时性的武器附魔."
L["ICONMENU_WPNENCHANTTYPE"] = "要监视的武器栏"
L["ICONTOCHECK"] = "要检测的图标"
L["ICON_TOOLTIP1"] = "TellMeWhen"
L["ICON_TOOLTIP2NEW"] = [=[|cff7fffff点击鼠标右键|r进入图标设置.
|cff7fffff点击鼠标右键并拖拽|r 移动/复制 到另一个图标.
|cff7fffff拖拽|r法术或者物品到图标上进行快速设置.]=]
L["ImmuneToMagicCC"] = "免疫魔法控制"
L["ImmuneToStun"] = "免疫昏迷"
L["IMPORTERROR_FAILEDPARSE"] = "处理字符串时发生错误.请确保你复制的字符串是完整的."
L["IMPORT_EXPORT"] = "导出/导入/还原"
L["IMPORT_EXPORT_BUTTON_DESC"] = "点击此下拉式菜单来导入或导出图标/分组/配置文件."
L["IMPORT_EXPORT_DESC"] = [=[点击这个编辑框右侧的下拉式菜单的箭头来导出图标,分组或配置文件.

导出/导入字符串或发送给其他玩家需要使用这个编辑框. 具体的使用方法请看下拉式菜单上的提示信息.]=]
L["IMPORT_EXPORT_DESC_INLINE"] = "导出配置文件/分组/图标到字符串/其他玩家/其他配置文件/个人设置备份. 或从字符串/其他玩家/其他配置文件/个人设置备份导入到配置文件/分组/图标."
L["IMPORT_FROMBACKUP"] = "来自备份"
L["IMPORT_FROMBACKUP_DESC"] = "用这个菜单可以还原设置到: %s"
L["IMPORT_FROMBACKUP_WARNING"] = "备份设置: %s"
L["IMPORT_FROMCOMM"] = "来自玩家"
L["IMPORT_FROMCOMM_DESC"] = "如果其他TellMeWhen使用者给你发送了配置数据,可以从这个子菜单导入那些数据."
L["IMPORT_FROMLOCAL"] = "来自配置文件"
L["IMPORT_FROMSTRING"] = "来自字符串"
L["IMPORT_FROMSTRING_DESC"] = [=[字符串允许你在游戏以外的地方转存TellMeWhen配置数据.(包括用来给其他人分享自己的设置,或者导入其他人分享的设置,也可用来备份你自己的设置.)

从字符串导入的方法: 当复制TMW字符串到你的剪切板后,在'导出/导入'编辑框中按下CTRL+V贴上字符串,然后返回浏览这个子菜单.]=]
L["IMPORT_FROMSTRING_ERR_NOICONS"] = "请使用'图标编辑器'导入图标"
L["IMPORT_HEADING"] = "导入"
L["IMPORT_PROFILE"] = "复制配置文件"
L["IMPORT_PROFILE_NEW"] = "创建新的配置文件"
L["IMPORT_PROFILE_OVERWRITE"] = "覆盖 %s"
L["Incapacitated"] = "被瘫痪"
L["IncreasedAP"] = "攻击强度提高"
L["IncreasedCrit"] = "暴击几率提高"
L["IncreasedDamage"] = "造成的伤害提高"
L["IncreasedPhysHaste"] = "物理急速提高"
L["IncreasedSpellHaste"] = "法术急速提高"
L["IncreasedSPsix"] = "法术强度提高 (6%)"
L["IncreasedSPten"] = "法术强度提高 (10%)"
L["IncreasedStats"] = "属性提高"
L["INRANGE"] = "在范围内"
L["ITEMCOOLDOWN"] = "物品冷却"
L["ITEMEQUIPPED"] = "已装备物品"
L["ITEMINBAGS"] = "物品计数(包含次数)"
L["ITEMTOCHECK"] = "要检测的物品"
L["ITEMTOCOMP1"] = "进行比较的第一个物品"
L["ITEMTOCOMP2"] = "进行比较的第二个物品"
L["LDB_TOOLTIP1"] = "|cff7fffff左键点击|r 锁定或解锁分组"
L["LDB_TOOLTIP2"] = "|cff7fffff右键点击|r 显示主选项"
L["LEFT"] = "左"
L["LOADERROR"] = "TellMeWhen设置插件无法加载:"
L["LOADINGOPT"] = "正在加载TellMeWhen设置插件."
L["LOCKED"] = "已锁定"
L["LUACONDITION"] = "Lua(高玩级)"
L["LUACONDITION_DESC"] = [=[此条件类型允许你使用Lua语言来评估一个条件的状态.(非高玩慎入!)

输入不能为'if..then'叙述,也不能为function closure.它可以是一个普通的叙述评估,例如:'a and b or c'.如果需要复杂功能,可使用函数调用,​​例如:'CheckStuff()',这是一个外部函数.

如果需要更多的帮助(但不是关于如何去写Lua代码),到CurseForge提交一份回报单.关于如何编写Lua代码,请自行去互联网搜索资料.

PS:Lua语言部份就不翻译了,翻译了反而觉得怪怪的.]=]
L["MACROCONDITION"] = "宏命令条件语"
L["MACROCONDITION_DESC"] = [=[此条件将会评估宏命令条件语,在宏命令条件语成立时则此条件通过.
所有的宏命令条件语都能在前面加上"no"进行逆向检测.
例子:
"[nomodifier:alt]" - 没有按住ALT键
"[@target, help][mod:ctrl]" - 目标是友好的或者按住CTRL键
"[@focus, harm, nomod:shift]" - 焦点目标是敌对的同时没有按住SHIFT键

需要更多的帮助,请访问http://www.wowpedia.org/Making_a_macro]=]
L["MACROCONDITION_EB_DESC"] = "使用单一条件时中括号是可选的,使用多个条件语时中括号是必须的.​​(说明:中括号->'[ ]')"
L["MACROTOEVAL"] = "输入需要评估的宏命令条件语(允许多个)"
L["Magic"] = "魔法"
L["MAIN"] = "主页面"
L["!!Main Addon Description"] = "为冷却、增益/减益及其他各个方面提供视觉、听觉以及文字上的通知。"
L["MAINASSIST"] = "主助攻"
L["MAINTANK"] = "主坦克"
L["MAKENEWGROUP"] = "创建新分组"
L["ManaRegen"] = "法力回复提高"
L["MELEECRIT"] = "近战致命"
L["MELEEHASTE"] = "近战加速"
L["MESSAGERECIEVE"] = "%s给你发送了一些TellMeWhen数据!你可以使用图标编辑器中的 %q 下拉式菜单把数据导入TellMeWhen."
L["MESSAGERECIEVE_SHORT"] = "%s给你发送了一些TellMeWhen数据!"
L["METAPANEL_DOWN"] = "往下移动"
L["METAPANEL_INSERT"] = "插入一个图标"
L["METAPANEL_REMOVE"] = "移除此图标"
L["METAPANEL_UP"] = "往上移动"
L["MiscHelpfulBuffs"] = "其他增益"
L["MOON"] = "月蚀"
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "无鼠标悬停目标"
L["MP5"] = "%d 5秒回蓝"
L["MUSHROOM"] = "蘑菇 %d"
L["MUSHROOMS"] = "检测蘑菇"
L["NEWVERSION"] = "检测到TellMeWhen的新版本(%s)"
L["NONE"] = "不包含任何一个"
L["normal"] = "普通"
L["NOTINRANGE"] = "不在范围内"
L["NUMAURAS"] = "数量"
L["NUMAURAS_DESC"] = [=[此条件仅检测一个作用中的法术效果的数量- 不要与法术效果的叠加数量混淆.
像是你的两个相同的武器附魔特效同时触发并且在作用中.
请有节制的使用它,此过程需要消耗不少CPU运算来计算数量.]=]
L["ONGROUPDELETE_CHECKINGINVALID"] = "警告! 下列分组和图标正在检测那个刚被你删除的分组中的某些图标:"
L["ONLYCHECKMINE"] = "仅检测自己施放的"
L["ONLYCHECKMINE_DESC"] = "选择此项让该条件只检测自己的增益/减益"
L["OUTLINE_MONOCHORME"] = "单色"
L["OUTLINE_NO"] = "没有描边"
L["OUTLINE_THICK"] = "粗描边"
L["OUTLINE_THIN"] = "细描边"
L["OVERWRITEGROUP"] = "覆盖分组: %s"
L["PARENTHESIS_TYPE_("] = "左括号'('"
L["PARENTHESIS_TYPE_)"] = "右括号')'"
L["PARENTHESIS_WARNING1"] = [=[左右括号的数量不相等!

缺少%d个%s.]=]
L["PARENTHESIS_WARNING2"] = [=[一些右括号缺少左括号!

缺少%d个左括号'('.]=]
L["PET_TYPE_CUNNING"] = "狡诈"
L["PET_TYPE_FEROCITY"] = "狂野"
L["PET_TYPE_TENACITY"] = "坚韧"
L["PhysicalDmgTaken"] = "受到的物理伤害提高"
L["PLAYER_DESC"] = "(你)"
L["Poison"] = "毒"
L["PRESENCE"] = "灵气(领域)"
L["PushbackResistance"] = "施法打退抵抗提高"
L["PvPSpells"] = "PVP控场技能等"
L["RANGEDCRIT"] = "物理远程致命"
L["RANGEDHASTE"] = "物理远程急速"
L["rare"] = "稀有"
L["rareelite"] = "稀有精英"
L["REACTIVECNDT_DESC"] = "此条件仅检测技能的触发/激活情况,并非它的冷却."
L["REDO_ICON"] = "恢复"
L["REDO_ICON_DESC"] = "恢复最近一次图标设置的撤消动作."
L["ReducedArmor"] = "降低护甲"
L["ReducedAttackSpeed"] = "降低攻击强度"
L["ReducedCastingSpeed"] = "降低施法速度"
L["ReducedHealing"] = "治疗效果降低"
L["ReducedPhysicalDone"] = "造成的物理伤害降低"
L["RESET_CONFIRM"] = "确认重置"
L["RESET_EXPIRE"] = "重置已超时,你没有在5秒内再次按下'重置'按钮."
L["RESET_ICON"] = "重置"
L["RESET_NOTIFY"] = "请在5秒內再次按下 '重置' 按钮."
L["Resistances"] = "法术抗性提高"
L["RESIZE"] = "调整大小"
L["RESIZE_TOOLTIP"] = "点击并拖拽改变大小"
L["RIGHT"] = "右"
L["Rooted"] = "被缠绕"
L["RUNES"] = "要检测的符文"
L["RUNSPEED"] = "单位奔跑速度"
L["SENDSUCCESSFUL"] = "已成功发送"
L["SHAPESHIFT"] = "变身"
L["Shatterable"] = "冰冻"
L["Silenced"] = "被沉默"
L["Slowed"] = "被减速"
L["SORTBY"] = "排列方式"
L["SORTBYNONE"] = "正常排列"
L["SORTBYNONE_DESC"] = [=[如果选中,法术将按照"%s"编辑框中的输入顺序来检测并排列.
如果是一个增益/减益图标,只要出现在单位框体上的法术效果数字没有超出效率阀值设定,就会被检测并排列.

(PS:如果看不懂请无视这段说明,只要知道它是按照你输入的顺序来排列就好.)]=]
L["SOUND_CUSTOM"] = "自定义音效文件"
L["SOUND_CUSTOM_DESC"] = [=[输入需要用来播放的自定义音效文件的路径.
下面是一些例子,其中"File"是你的音效文件名,"ext"是后缀名(只能用ogg或者mp3格式)

-"CustomSounds\File.ext": 一个文件放在WOW主目录一个命名为"CustomSound"的新建文件夹中(此文件夹同WOW.exe,Interface和WTF在同一位置)
-"Interface\AddOns\file.ext": 插件文件夹中的某一文件
-"file.ext": WOW主目录的某个文件]=]
L["SOUNDERROR1"] = "文件必须有后缀名!"
L["SOUNDERROR2"] = "魔兽世界4.0+不支持自定义WAV文件"
L["SOUNDERROR3"] = "只支持OGG跟MP3文件!"
L["SOUND_EVENT_DISABLEDFORTYPE"] = "不可用"
L["SOUND_EVENT_DISABLEDFORTYPE_DESC"] = "此事件不可用于图标类型 %s"
L["SOUND_EVENT_GLOBALDESC"] = "在此列表中的事件是按照从上到下的顺序来检测.如果一个事件触发并且播放了音效,在它之后的事件不会再播放任何音效."
L["SOUND_EVENT_ONALPHADEC"] = "透明度百分比减少"
L["SOUND_EVENT_ONALPHADEC_DESC"] = [=[当图标的不透明度降低时触发此事件.

注意:不透明度在降低后如果为0%不会触发此事件(如果有需要请使用"在隐藏时").]=]
L["SOUND_EVENT_ONALPHAINC"] = "透明度百分比增加"
L["SOUND_EVENT_ONALPHAINC_DESC"] = [=[当图标的不透明度提高时触发此事件.

注意:不透明度在提高前如果为0%不会触发此事件(如果有需要请使用"在显示时").]=]
L["SOUND_EVENT_ONDURATION"] = "持续时间改变"
L["SOUND_EVENT_ONDURATION_DESC"] = [=[此事件在图标计时器的持续时间改变时触发.

因为在计时器运行时每次图标更新都会触发该事件,你必须设置一个条件,使事件仅在条件的状态改变时触发.]=]
L["SOUND_EVENT_ONFINISH"] = "结束"
L["SOUND_EVENT_ONFINISH_DESC"] = "当冷却结束,增益/减益消失,等相似的情况下触发此事件."
L["SOUND_EVENT_ONHIDE"] = "隐藏"
L["SOUND_EVENT_ONHIDE_DESC"] = "当图标隐藏时触发此事件.(即使 %q 已勾选)"
L["SOUND_EVENT_ONSHOW"] = "显示"
L["SOUND_EVENT_ONSHOW_DESC"] = "当图标显示时触发此事件.(即使 %q 已勾选)"
L["SOUND_EVENT_ONSPELL"] = "法术改变"
L["SOUND_EVENT_ONSPELL_DESC"] = "当图标显示信息中的法术/物品/等改变时触发此事件."
L["SOUND_EVENT_ONSTACK"] = "叠加数量改变"
L["SOUND_EVENT_ONSTACK_DESC"] = [=[此事件在图标所检测的法术/物品等的叠加数量发生改变时触发.

包括逐渐降低的%s图标.]=]
L["SOUND_EVENT_ONSTART"] = "开始"
L["SOUND_EVENT_ONSTART_DESC"] = "当冷却开始,增益/减益开始作用,等相似的情况下触发此事件."
L["SOUND_EVENT_ONUNIT"] = "单位改变"
L["SOUND_EVENT_ONUNIT_DESC"] = "当图标显示信息中的单位改变时触发此事件."
L["SOUND_EVENTS"] = "图标事件"
L["SOUND_SOUNDTOPLAY"] = "要播放的音效"
L["SOUND_TAB"] = "音效"
L["SOUND_USEMASTER"] = "始终播放音效"
L["SOUND_USEMASTER_DESC"] = "勾选此项允许在游戏音效静音时同样播放音效(最上面的开启音效必须打开),取消此项只在游戏音效开启时播放音效."
L["SPEED"] = "单位速度"
L["SPEED_DESC"] = [=[这是指单位当前的移动速度,如果单位不移动则为0.
如果您要检测单位的最高奔跑速度,可以使用"单位奔跑速度"条件来代替.]=]
L["SPELLCOOLDOWN"] = "法术冷却"
L["SPELLCRIT"] = "法术致命"
L["SpellCritTaken"] = "受到的法术暴击几率提高"
L["SpellDamageTaken"] = "受到的的法术伤害提高"
L["SPELLHASTE"] = "法术急速"
L["SPELLREACTIVITY"] = "法术反应(激活/触发/可能)"
L["SPELLTOCHECK"] = "要检测的法术"
L["SPELLTOCOMP1"] = "进行比较的第一个法术"
L["SPELLTOCOMP2"] = "进行比较的第二个法术"
L["STACKS"] = "叠加数量"
L["STACKSPANEL_TITLE"] = "叠加数量"
L["STANCE"] = "姿态"
L["STRATA_BACKGROUND"] = "背景(最低)"
L["STRATA_DIALOG"] = "对话框"
L["STRATA_FULLSCREEN"] = "全屏幕"
L["STRATA_FULLSCREEN_DIALOG"] = "全屏幕对话框"
L["STRATA_HIGH"] = "高"
L["STRATA_LOW"] = "低"
L["STRATA_MEDIUM"] = "中"
L["STRATA_TOOLTIP"] = "提示信息(最高)"
L["Stunned"] = "被昏迷"
L["SUG_BUFFEQUIVS"] = "同类型增益"
L["SUG_CLASSSPELLS"] = "已知玩家/宠物的法术"
L["SUG_DEBUFFEQUIVS"] = "同类型减益"
L["SUG_DISPELTYPES"] = "驱散类型"
L["SUG_FINISHHIM"] = "马上结束缓存"
L["SUG_FINISHHIM_DESC"] = "点击快速完成该缓存/筛选过程. 友情提示:你的电脑可能会因此停格几秒钟."
L["SUGGESTIONS"] = "提示与建议:"
L["SUG_INSERT_ANY"] = "|cff7fffff点击鼠标|r"
L["SUG_INSERTID"] = "%s插入编号(ID)"
L["SUG_INSERTITEMSLOT"] = "%s插入物品对应的装备栏编号"
L["SUG_INSERT_LEFT"] = "|cff7fffff点击鼠标左键|r"
L["SUG_INSERTNAME"] = "%s插入名称"
L["SUG_INSERT_RIGHT"] = "|cff7fffff点击鼠标右键|r"
L["SUG_MATCH_WPNENCH_ENCH"] = "(.*)武器"
L["SUG_MISC"] = "杂项"
L["SUG_MSCDONBARS"] = "有效的多重状态冷却"
L["SUG_NPCAURAS"] = "已知NPC的增益/减益"
L["SUG_OTHEREQUIVS"] = "其他同类型"
L["SUG_PATTERNMATCH_FISHINGLURE"] = "鱼饵%（%+%d+钓鱼技能%）"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "磨快%（%+%d+伤害%）"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "增重%（%+%d+伤害%）"
L["SUG_PLAYERAURAS"] = "已知玩家/宠物的增益/减益"
L["SUG_PLAYERSPELLS"] = "你的法术"
L["SUG_TOOLTIPTITLE"] = [=[当你输入时,TellMeWhen将会在缓存中查找并提示你最有可能输入的法术.

法术按照以下列表分类跟着色.
注意:在记录到相应的数据之前或者在你没有登陆过其他的职业的情况下不会把那些法术放入"已知"开头的分类中.

点击一个条目将其插入到编辑框.

]=]
L["SUN"] = "日蚀"
L["TANK"] = "坦克"
L["Tier11Interrupts"] = "T11副本可打断的施法"
L["Tier12Interrupts"] = "T12副本可打断法术"
L["TOOLTIPSCAN"] = "法术效果变量"
L["TOOLTIPSCAN_DESC"] = "此条件类型允许你检测某一单位的某个法术效果提示信息上的第一个变量(数字).数字是由暴雪API所提供,跟你在法术效果的提示信息中看到的数字可能会不同(像是服务器已经在线修正,客户端依然显示错误的数字这种情况),同时也不保证一定能够从法术效果获取一个数字,不过在大多数实际情况下都能检测到正确的数字."
L["TOP"] = "上"
L["TOPLEFT"] = "左上"
L["TOPRIGHT"] = "右上"
L["TOTEMS"] = "检测图腾"
L["TRUE"] = "是"
L["UIPANEL_ADDGROUP"] = "+ 新增分组 +"
L["UIPANEL_ADDGROUP_DESC"] = "新分组将分配到下一个可用的分组ID"
L["UIPANEL_ALLRESET"] = "全部重置"
L["UIPANEL_BARIGNOREGCD"] = "计量条忽略公共冷却"
L["UIPANEL_BARIGNOREGCD_DESC"] = "如果选中,冷却条在公共冷却时不改变值."
L["UIPANEL_BARTEXTURE"] = "计量条材质"
L["UIPANEL_CLOCKIGNOREGCD"] = "计时器忽略公共冷却"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "如果选中，计时器和冷却将忽略公共CD来触发"
L["UIPANEL_COLOR_ABSENT"] = "缺少时的颜色"
L["UIPANEL_COLOR_ABSENT_DESC"] = "当增益/减益/暂时性武器附魔/图腾不存在并且图标设置为一直显示时图标的色调."
L["UIPANEL_COLOR_COMPLETE"] = "冷却/持续完成"
L["UIPANEL_COLOR_COMPLETE_DESC"] = "当冷却/持续完成时的冷却/持续条的颜色"
L["UIPANEL_COLOR_DESC"] = "下列选项的图标颜色仅作用于图标设置为一直显示时"
L["UIPANEL_COLOR_OOM"] = "能量不足时的颜色"
L["UIPANEL_COLOR_OOM_DESC"] = "当你缺少魔法/怒气/能量/集中值/符文能量来施放法术时，图标的色调和透明度"
L["UIPANEL_COLOR_OOR"] = "超出距离的颜色"
L["UIPANEL_COLOR_OOR_DESC"] = "当你和目标的距离超出范围时，图标的色调和透明度"
L["UIPANEL_COLOR_PRESENT"] = "存在时的颜色"
L["UIPANEL_COLOR_PRESENT_DESC"] = "当增益/减益/暂时性武器附魔/图腾存在并且图标设置为一直显示时图标的色调。"
L["UIPANEL_COLORS"] = "颜色"
L["UIPANEL_COLOR_STARTED"] = "冷却/持续开始"
L["UIPANEL_COLOR_STARTED_DESC"] = "当冷却/持续开始时的冷却/持续条的颜色"
L["UIPANEL_COLUMNS"] = "列"
L["UIPANEL_DELGROUP"] = "删除该分组"
L["UIPANEL_DELGROUP_DESC"] = [=[在此分组之后的任意分组ID将会上升1.
同时对ID上升组的图标有检测行为的所有图标的设置也将自动更新.

按住|cff7fffffCtrl|r键跳过确认.]=]
L["UIPANEL_DRAWEDGE"] = "高亮计时器指针"
L["UIPANEL_DRAWEDGE_DESC"] = "高亮冷却计时器的指针来改善可视性"
L["UIPANEL_EFFTHRESHOLD"] = "增益效率閥值"
L["UIPANEL_EFFTHRESHOLD_DESC"] = "输入增益/减益的最小时间以便在它们有很高的数值时切换到更有效的检测模式. 注意:一旦效果的数值超出所选择的数字的限定,数值较大的效果会优先显示,而不是按照设定的优先级顺序."
L["UIPANEL_ENABLEGROUP"] = "启用分组"
L["UIPANEL_FONT_Bind"] = "绑定/标签文字"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "限制宽度"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [=[勾选此项在位置恰当的情况下文字宽度会强制跟图标宽度进行匹配.
取消勾选将允许文字延升宽度大于图标.]=]
L["UIPANEL_FONT_Count"] = "叠加数量文字"
L["UIPANEL_FONT_DESC"] = "选择图标的叠加数量文字所使用的字体"
L["UIPANEL_FONTFACE"] = "字体"
L["UIPANEL_FONT_OUTLINE"] = "字体描边"
L["UIPANEL_FONT_OUTLINE_DESC"] = "设置图标叠加数量文字的轮廓样式"
L["UIPANEL_FONT_OVERRIDELBF"] = "使用Masque(ButtonFacade)覆盖位置"
L["UIPANEL_FONT_OVERRIDELBF_DESC"] = [=[勾选此项在Masque(ButtonFacade)皮肤的设置已定义时覆盖叠加数量文字位置.如果你没有使用Masque(ButtonFacade)请忽略此选项.

如果你选择在启用之后禁用此选项来还原文字的皮肤设置需要重载插件或更改皮肤.]=]
L["UIPANEL_FONT_SIZE"] = "字体大小"
L["UIPANEL_FONT_SIZE_DESC"] = "更改图标叠加数量文字的字体大小.如果已使用ButtonFacade(Masque)并且所设置的皮肤的字体大小已定义将忽略此设置值."
L["UIPANEL_FONT_XOFFS"] = "X偏移"
L["UIPANEL_FONT_YOFFS"] = "Y偏移"
L["UIPANEL_GROUPNAME"] = "重命名此分组"
L["UIPANEL_GROUPRESET"] = "重置位置"
L["UIPANEL_GROUPS"] = "分组"
L["UIPANEL_ICONS"] = "图标"
L["UIPANEL_ICONSPACING"] = "图标间距"
L["UIPANEL_ICONSPACING_DESC"] = "同组图标之间的间隔距离"
L["UIPANEL_LEVEL"] = "框体优先级"
L["UIPANEL_LOCK"] = "锁定位置"
L["UIPANEL_LOCK_DESC"] = "锁定该组,禁止移动或改变比例."
L["UIPANEL_LOCKUNLOCK"] = "锁定/解锁插件"
L["UIPANEL_MAINOPT"] = "主选项"
L["UIPANEL_ONLYINCOMBAT"] = "仅在战斗中显示"
L["UIPANEL_POINT"] = "附着点"
L["UIPANEL_POSITION"] = "位置"
L["UIPANEL_PRIMARYSPEC"] = "主天赋"
L["UIPANEL_PTSINTAL"] = "天赋使用点数(非天赋树)"
L["UIPANEL_RELATIVEPOINT"] = "附着位置"
L["UIPANEL_RELATIVETO"] = "附着框体"
L["UIPANEL_RELATIVETO_DESC"] = [=[输入'/framestack'来观察当前鼠标指针所在框体的提示信息,以便寻找需要输入文本框的框体名称.

需要更多帮助,请访问http://www.wowpedia.org/API_Region_SetPoint]=]
L["UIPANEL_ROWS"] = "行"
L["UIPANEL_SCALE"] = "比例"
L["UIPANEL_SECONDARYSPEC"] = "副天赋"
L["UIPANEL_SPEC"] = "双天赋"
L["UIPANEL_STRATA"] = "框体层级"
L["UIPANEL_SUBTEXT2"] = "图标在锁定后开始工作。当解锁后，你可以移动/修改图标分组大小，右键点击单个图标可进行更多设置。你可以输入'/tellmewhen'或'/tmw'来锁定/解锁。。"
L["UIPANEL_TOOLTIP_ALLRESET"] = "重置所有图标和分组的数据、位置以及其它设置"
L["UIPANEL_TOOLTIP_COLUMNS"] = "设置在本组中的图标列数"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "显示并启用该分組"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "重置该组的位置跟比例"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "勾选此项使该分组仅在战斗中显示"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "选中后当你启用主天赋时显示这个分组的图标"
L["UIPANEL_TOOLTIP_ROWS"] = "设置在本组中的图标行数"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "选中后当你启用副天赋时显示这个分组的图标"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = "设置图标显示/隐藏,透明度,条件等的更新频率(秒).0为最快.低端电脑请自重,设置数值过低会使帧数明显降低."
L["UIPANEL_TREE"] = "天赋树"
L["UIPANEL_TREE_DESC"] = "勾选来允许该组在某个天赋树激活时显示，或者不勾选让它在天赋树没激活时隐藏。"
L["UIPANEL_UPDATEINTERVAL"] = "更新间隔"
L["UIPANEL_WARNINVALIDS"] = "提示无效的图标"
L["UNDO_ICON"] = "撤消"
L["UNDO_ICON_DESC"] = "撤消最近一次图标设置的更改动作."
L["UNDOREDO_ICON_NOBIND"] = "你可以在暴雪的按键绑定设置界面中为 撤消 或 恢复 设置一个快捷键."
L["UNITTWO"] = "第二单位"
L["UNNAMED"] = "((未命名))"
L["WARN_DRMISMATCH"] = [=[警告!你正在检测递减的法术来自两个不同的已知分类.

在同一个递减图标中,用于检测的所有法术应当使用同一递减分类才能使图标正常运行.

检测到下列你所使用的法术及其分类:]=]
L["WATER"] = "水之图腾"
L["worldboss"] = "首领"
