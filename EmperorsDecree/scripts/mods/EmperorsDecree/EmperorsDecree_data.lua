local mod = get_mod("EmperorsDecree")

return {
	name = mod:localize("mod_name"),
	description = mod:localize("mod_description"),
	is_togglable = true,
	options = {
		widgets = {
			{
				setting_id = "group_operative_selection",
				type = "group",
				tab = mod:localize("tab_operative"),
				sub_widgets = {
					{
						setting_id = "random_character_on_startup",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "auto_reload_hub_on_switch",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "filter_max_level_only",
						type = "checkbox",
						default_value = false,
					},
					{
						setting_id = "keybind_decree_all",
						type = "keybind",
						default_value = {},
						keybind_global = true,
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "decree_all",
					},
					{
						setting_id = "keybind_reroll_character",
						type = "keybind",
						default_value = {},
						keybind_global = true,
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "reroll_operative",
					},
				},
			},
			{
				setting_id = "group_class_filters",
				type = "group",
				tab = mod:localize("tab_operative"),
				sub_widgets = {
					{
						setting_id = "allow_class_veteran",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_zealot",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_psyker",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_ogryn",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_hivescum",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_adamant",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "allow_class_skitarii",
						type = "checkbox",
						default_value = true,
					},
				},
			},
			{
				setting_id = "group_loadout_selection",
				type = "group",
				tab = mod:localize("tab_loadout"),
				sub_widgets = {
					{
						setting_id = "random_loadout_on_character_select",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "skip_empty_loadouts",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "keybind_reroll_loadout",
						type = "keybind",
						default_value = {},
						keybind_global = true,
						keybind_trigger = "pressed",
						keybind_type = "function_call",
						function_name = "reroll_loadout",
					},
				},
			},
			{
				setting_id = "group_messages",
				type = "group",
				tab = mod:localize("tab_messages"),
				sub_widgets = {
					{
						setting_id = "enable_notifications",
						type = "checkbox",
						default_value = true,
					},
					{
						setting_id = "enable_chat_messages",
						type = "checkbox",
						default_value = true,
					},
				},
			},
		},
	},
}
