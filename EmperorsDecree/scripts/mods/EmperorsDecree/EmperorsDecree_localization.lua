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
	random_character_on_startup_desc = {
		en = "When entering the operative selection screen, the Emperor decrees an operative matching your active class filters.",
	},
	auto_reload_hub_on_switch = {
		en = "Auto-Reload Mourningstar on Switch",
	},
	auto_reload_hub_on_switch_desc = {
		en = "When switching operative from inside the Mourningstar, automatically reload into the hub with your newly decreed operative.",
	},
	keybind_decree_all = {
		en = "Roll All Hotkey (Character & Loadout)",
	},
	keybind_decree_all_desc = {
		en = "Universal hotkey to randomize both your character and loadout preset in one press. In the Mourningstar, it switches your character, equips a random loadout, and automatically reloads the hub.",
	},
	keybind_reroll_character = {
		en = "Reroll Character Only Hotkey",
	},
	keybind_reroll_character_desc = {
		en = "Hotkey to randomize only your character (at the character selection screen or in the Mourningstar).",
	},
	allow_class_veteran = {
		en = "Allow Veteran",
	},
	allow_class_veteran_desc = {
		en = "Allow Veteran operatives to be chosen.",
	},
	allow_class_zealot = {
		en = "Allow Zealot",
	},
	allow_class_zealot_desc = {
		en = "Allow Zealot operatives to be chosen.",
	},
	allow_class_psyker = {
		en = "Allow Psyker",
	},
	allow_class_psyker_desc = {
		en = "Allow Psyker operatives to be chosen.",
	},
	allow_class_ogryn = {
		en = "Allow Ogryn",
	},
	allow_class_ogryn_desc = {
		en = "Allow Ogryn operatives to be chosen.",
	},
	allow_class_hivescum = {
		en = "Allow Hive Scum",
	},
	allow_class_hivescum_desc = {
		en = "Allow Hive Scum operatives to be chosen.",
	},
	allow_class_adamant = {
		en = "Allow Adamant",
	},
	allow_class_adamant_desc = {
		en = "Allow Adamant operatives to be chosen.",
	},
	allow_class_skitarii = {
		en = "Allow Skitarii",
	},
	allow_class_skitarii_desc = {
		en = "Allow Skitarii operatives to be chosen.",
	},
	filter_max_level_only = {
		en = "Over Level 30 Characters Only",
	},
	filter_max_level_only_desc = {
		en = "Restricts operative selection strictly to characters at or over level 30.",
	},
	random_loadout_on_character_select = {
		en = "Randomize Loadout on Operative Select",
	},
	random_loadout_on_character_select_desc = {
		en = "Automatically selects a random saved loadout preset when an operative is selected.",
	},
	keybind_reroll_loadout = {
		en = "Reroll Loadout Only Hotkey",
	},
	keybind_reroll_loadout_desc = {
		en = "Hotkey to randomize only your saved loadout preset without changing your character (in the Mourningstar, Psykhanium, or Inventory).",
	},
	skip_empty_loadouts = {
		en = "Skip Empty / Incomplete Loadouts",
	},
	skip_empty_loadouts_desc = {
		en = "Excludes saved loadouts that do not have equipment or talent trees configured.",
	},
	enable_notifications = {
		en = "Show On-Screen Notifications",
	},
	enable_notifications_desc = {
		en = "Displays an Imperial decree banner when your operative or loadout is randomized.",
	},
	enable_chat_messages = {
		en = "Show Chat Messages",
	},
	enable_chat_messages_desc = {
		en = "Prints the Emperor's decree results into your local chat feed.",
	},
	msg_no_eligible_operatives = {
		en = "The Emperor finds no operatives fitting your decreed filters!",
	},
	msg_operative_decreed = {
		en = "By the Emperor's Decree: Deploying as %s (%s, Lvl %d).",
	},
	msg_decree_both = {
		en = "By the Emperor's Decree: %s (%s, Lvl %d) with Loadout '%s'.",
	},
	msg_loadout_decreed = {
		en = "By the Emperor's Decree: Loadout '%s' assigned.",
	},
	msg_no_loadouts_found = {
		en = "No saved loadouts found for this operative!",
	},
	msg_redeploying = {
		en = "By the Emperor's Decree: Redeploying to Mourningstar as %s (%s, Lvl %d)...",
	},
	msg_redeploying_with_loadout = {
		en = "By the Emperor's Decree: Redeploying to Mourningstar as %s (%s, Lvl %d) with Loadout '%s'...",
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
		en = "Emperor's Decree Commands:\n- /decree (alts: all, roll, random) : Randomize operative & loadout\n- /decree operative (alts: character, class, op) : Randomize operative\n- /decree loadout (alts: preset, build) : Randomize loadout preset\n- /decree help : Show available commands",
	},
}
