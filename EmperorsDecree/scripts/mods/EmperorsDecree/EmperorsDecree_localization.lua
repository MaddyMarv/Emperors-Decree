local mod = get_mod("EmperorsDecree")

return {
	mod_name = {
		en = "Emperor's Decree",
	},
	mod_description = {
		en = "Randomly chooses an operative and a saved loadout preset according to the divine will of the God-Emperor of Mankind.",
	},
	tab_operative = {
		en = "Operative Decrees",
	},
	tab_loadout = {
		en = "Loadout Decrees",
	},
	tab_messages = {
		en = "Decree Notifications",
	},
	group_operative_selection = {
		en = "Operative Selection",
	},
	group_class_filters = {
		en = "Allowed Operative Classes",
	},
	group_loadout_selection = {
		en = "Loadout Preset Selection",
	},
	group_messages = {
		en = "Notifications & Chat",
	},
	random_character_on_startup = {
		en = "Randomize Operative on Start",
	},
	random_character_on_startup_description = {
		en = "When entering the operative selection screen, the Emperor decrees an operative matching your active class filters.",
	},
	auto_reload_hub_on_switch = {
		en = "Auto-Reload Mourningstar on Switch",
	},
	auto_reload_hub_on_switch_description = {
		en = "When switching operative from inside the Mourningstar, automatically reload into the hub with your newly decreed operative.",
	},
	keybind_reroll_character = {
		en = "Reroll Operative Hotkey",
	},
	keybind_reroll_character_description = {
		en = "Hotkey to randomize your operative (at character selection or from the Mourningstar).",
	},
	allow_class_veteran = {
		en = "Allow Veteran",
	},
	allow_class_veteran_description = {
		en = "Allow Veteran operatives to be chosen.",
	},
	allow_class_zealot = {
		en = "Allow Zealot",
	},
	allow_class_zealot_description = {
		en = "Allow Zealot operatives to be chosen.",
	},
	allow_class_psyker = {
		en = "Allow Psyker",
	},
	allow_class_psyker_description = {
		en = "Allow Psyker operatives to be chosen.",
	},
	allow_class_ogryn = {
		en = "Allow Ogryn",
	},
	allow_class_ogryn_description = {
		en = "Allow Ogryn operatives to be chosen.",
	},
	allow_class_hivescum = {
		en = "Allow Hive Scum",
	},
	allow_class_hivescum_description = {
		en = "Allow Hive Scum operatives to be chosen.",
	},
	allow_class_adamant = {
		en = "Allow Adamant",
	},
	allow_class_adamant_description = {
		en = "Allow Adamant operatives to be chosen.",
	},
	allow_class_skitarii = {
		en = "Allow Skitarii",
	},
	allow_class_skitarii_description = {
		en = "Allow Skitarii operatives to be chosen.",
	},
	filter_max_level_only = {
		en = "Over Level 30 Characters Only",
	},
	filter_max_level_only_description = {
		en = "Restricts operative selection strictly to characters at or over level 30.",
	},
	random_loadout_on_character_select = {
		en = "Also Randomize Saved Preset on Operative Reroll",
	},
	random_loadout_on_character_select_description = {
		en = "When an operative is decreed at startup or rerolled via hotkey, also randomly choose one of that operative's saved inventory loadout presets.",
	},
	keybind_reroll_loadout = {
		en = "Reroll Saved Loadout Preset Hotkey",
	},
	keybind_reroll_loadout_description = {
		en = "Hotkey to randomize only your active saved loadout preset without changing characters (in the Mourningstar, Psykhanium, or Inventory).",
	},
	skip_empty_loadouts = {
		en = "Skip Empty / Incomplete Loadout Presets",
	},
	skip_empty_loadouts_description = {
		en = "Excludes saved preset slots that have no equipment or talent trees configured.",
	},
	enable_notifications = {
		en = "Show On-Screen Notifications",
	},
	enable_notifications_description = {
		en = "Displays a banner notification detailing the Emperor's decree.",
	},
	enable_chat_messages = {
		en = "Show Chat Messages",
	},
	enable_chat_messages_description = {
		en = "Prints the Emperor's decree results into your local chat feed.",
	},
	msg_no_eligible_operatives = {
		en = "The Emperor finds no operatives fitting your decreed filters!",
	},
	msg_operative_decreed = {
		en = "By the Emperor's Decree: Deploying as %s (%s, Lvl %s).",
	},
	msg_decree_both = {
		en = "By the Emperor's Decree: %s (%s, Lvl %s) with Loadout '%s'.",
	},
	msg_loadout_decreed = {
		en = "By the Emperor's Decree: Loadout '%s' assigned.",
	},
	msg_no_loadouts_found = {
		en = "No saved loadouts found for this operative!",
	},
	msg_redeploying = {
		en = "By the Emperor's Decree: Redeploying to Mourningstar as %s (%s, Lvl %s)...",
	},
	msg_redeploying_with_loadout = {
		en = "By the Emperor's Decree: Redeploying to Mourningstar as %s (%s, Lvl %s) with Loadout '%s'...",
	},
	msg_cannot_switch_operative_here = {
		en = "Return to Operative Selection to change your deployed operative.",
	},
	msg_cannot_switch_loadout_here = {
		en = "Loadouts can only be changed in the Mourningstar, Psykhanium, or Operative Selection.",
	},
	cmd_decree_desc = {
		en = "The Emperor's Decree: Randomize operative or saved loadout preset.",
	},
	cmd_decree_help = {
		en = "Emperor's Decree Commands:\n- /decree : Reroll operative (and loadout preset if enabled)\n- /decree loadout : Reroll saved loadout preset only\n- /decree help : Show available commands",
	},
}
