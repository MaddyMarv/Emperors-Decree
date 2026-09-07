local mod = get_mod("EmperorsDecree")

local ItemUtils = require("scripts/utilities/items")
local ProfileUtils = require("scripts/utilities/profile_utils")

local ARCHETYPE_DISPLAY_NAMES = {
	veteran = "VETERAN",
	zealot = "ZEALOT",
	psyker = "PSYKER",
	ogryn = "OGRYN",
	broker = "HIVE SCUM",
	adamant = "ADAMANT",
	cryptic = "SKITARII",
	skitarii = "SKITARII",
	skitarius = "SKITARII",
}

local function _notify(text)
	if not text or text == "" then
		return
	end

	local mmv = Managers.ui and Managers.ui:view_instance("main_menu_view")
	local is_main_menu = mmv ~= nil or (Managers.state and Managers.state.game_mode == nil)

	if mod:get("enable_notifications") then
		mod:notify(text)
	end

	if mod:get("enable_chat_messages") then
		if not is_main_menu or not mod:get("enable_notifications") then
			mod:echo(text)
		end
	end
end

local function _get_archetype_title(profile)
	local arch_name = profile and profile.archetype and profile.archetype.name
	if not arch_name then
		return "OPERATIVE"
	end

	if ARCHETYPE_DISPLAY_NAMES[arch_name] then
		return ARCHETYPE_DISPLAY_NAMES[arch_name]
	end

	return string.upper(arch_name)
end

local function _is_profile_eligible(profile)
	if not profile then
		return false
	end

	if mod:get("filter_max_level_only") then
		local level = profile.current_level or 0
		if level < 30 then
			return false
		end
	end

	local arch_name = profile.archetype and profile.archetype.name
	if not arch_name then
		return false
	end

	if arch_name == "veteran" then
		return mod:get("allow_class_veteran")
	elseif arch_name == "zealot" then
		return mod:get("allow_class_zealot")
	elseif arch_name == "psyker" then
		return mod:get("allow_class_psyker")
	elseif arch_name == "ogryn" then
		return mod:get("allow_class_ogryn")
	elseif arch_name == "broker" then
		return mod:get("allow_class_hivescum")
	elseif arch_name == "adamant" then
		return mod:get("allow_class_adamant")
	elseif arch_name == "cryptic" or arch_name == "skitarii" or arch_name == "skitarius" then
		return mod:get("allow_class_skitarii")
	end

	return false
end

local function _get_eligible_profiles(profiles)
	local eligible = {}
	if not profiles then
		return eligible
	end

	for i, profile in ipairs(profiles) do
		if _is_profile_eligible(profile) then
			table.insert(eligible, {
				profile = profile,
				index = i,
			})
		end
	end

	return eligible
end

local function _get_preset_name(preset, index)
	if not preset then
		return tostring(index or "?")
	end

	local loadout_names_mod = get_mod and get_mod("LoadoutNames")
	if loadout_names_mod and loadout_names_mod.get_loadout_name then
		local custom_name = loadout_names_mod.get_loadout_name(preset.id)
		if custom_name and custom_name ~= "" then
			return custom_name
		end
	end

	if preset.name and preset.name ~= "" then
		return preset.name
	end

	return string.format("Loadout #%d", index or 1)
end

local function _select_random_preset_for_character(character_id)
	if not character_id then
		return nil, nil, nil
	end

	local save_manager = Managers.save
	local character_data = save_manager and save_manager:character_data(character_id)
	local presets = character_data and character_data.profile_presets

	if not presets or #presets == 0 then
		return nil, nil, nil
	end

	local skip_empty = mod:get("skip_empty_loadouts")
	local candidates = {}

	for i, preset in ipairs(presets) do
		local is_valid = true

		if skip_empty then
			local has_loadout = preset.loadout and not table.is_empty(preset.loadout)
			local has_talents = preset.talents and not table.is_empty(preset.talents)
			if not has_loadout and not has_talents then
				is_valid = false
			end
		end

		if is_valid then
			table.insert(candidates, {
				preset = preset,
				index = i,
			})
		end
	end

	if #candidates == 0 then
		for i, preset in ipairs(presets) do
			table.insert(candidates, {
				preset = preset,
				index = i,
			})
		end
	end

	local chosen_entry = math.random_array_entry(candidates)
	if not chosen_entry then
		return nil, nil, nil
	end

	local chosen_preset = chosen_entry.preset
	local chosen_index = chosen_entry.index
	local chosen_name = _get_preset_name(chosen_preset, chosen_index)

	character_data.active_profile_preset_id = chosen_preset.id
	save_manager:queue_save()

	return chosen_preset, chosen_index, chosen_name
end

mod:hook("StateMainMenu", "on_enter", function(func, self, parent, params, creation_context)
	if not mod._auto_reenter_hub and mod:get("random_character_on_startup") and params and params.profiles then
		local eligible = _get_eligible_profiles(params.profiles)
		if #eligible > 0 then
			local chosen = math.random_array_entry(eligible)
			params.selected_profile = chosen.profile

			if mod:get("random_loadout_on_character_select") and chosen.profile.character_id then
				local _, _, preset_name = _select_random_preset_for_character(chosen.profile.character_id)
				mod._startup_chosen_preset_name = preset_name
			end

			mod._startup_chosen_profile = chosen.profile
		end
	end

	func(self, parent, params, creation_context)
end)

mod:hook_safe("StateMainMenu", "event_main_menu_entered", function(self)
	if mod._startup_chosen_profile then
		local profile = mod._startup_chosen_profile
		local preset_name = mod._startup_chosen_preset_name
		mod._startup_chosen_profile = nil
		mod._startup_chosen_preset_name = nil

		local arch_title = _get_archetype_title(profile)
		local level = profile.current_level or 0

		if preset_name then
			_notify(mod:localize("msg_decree_both", profile.name or "Operative", arch_title, level, preset_name))
		else
			_notify(mod:localize("msg_operative_decreed", profile.name or "Operative", arch_title, level))
		end
	end
end)

mod:hook("StateMainMenu", "update", function(func, self, dt, t)
	func(self, dt, t)

	if mod._auto_reenter_hub then
		local profiles_syncing, character_syncing = self:waiting_for_profile_synchronization()
		if not profiles_syncing and not character_syncing then
			mod._auto_reenter_hub = nil
			Managers.event:trigger("event_state_main_menu_continue")
		end
	end
end)

local function _switch_operative_from_hub(target_character_id, chosen_profile)
	local preset_name = nil
	if mod:get("random_loadout_on_character_select") and target_character_id then
		local _, _, name = _select_random_preset_for_character(target_character_id)
		preset_name = name
	end

	if preset_name then
		_notify(mod:localize("msg_redeploying_with_loadout", chosen_profile.name or "Operative", _get_archetype_title(chosen_profile), chosen_profile.current_level or 0, preset_name))
	else
		_notify(mod:localize("msg_redeploying", chosen_profile.name or "Operative", _get_archetype_title(chosen_profile), chosen_profile.current_level or 0))
	end

	local account_service = Managers.data_service and Managers.data_service.account
	if account_service and account_service.set_selected_character_id then
		account_service:set_selected_character_id(target_character_id):next(function()
			mod._auto_reenter_hub = true
			if Managers.ui and Managers.ui:view_active("system_view") then
				Managers.ui:close_view("system_view")
			end
			if Managers.multiplayer_session and Managers.multiplayer_session.leave then
				Managers.multiplayer_session:leave("exit_to_main_menu")
			end
		end)
	end
end

mod.reroll_operative = function()
	local mmv = Managers.ui and Managers.ui:view_instance("main_menu_view")
	if mmv and mmv._character_list_widgets then
		local eligible_widgets = {}

		for i, widget in ipairs(mmv._character_list_widgets) do
			local profile = widget.content and widget.content.profile
			if profile and _is_profile_eligible(profile) then
				table.insert(eligible_widgets, {
					index = i,
					profile = profile,
				})
			end
		end

		if #eligible_widgets == 0 then
			_notify(mod:localize("msg_no_eligible_operatives"))
			return
		end

		local chosen = math.random_array_entry(eligible_widgets)
		mmv:_on_character_widget_selected(chosen.index)

		local profile = chosen.profile
		local arch_title = _get_archetype_title(profile)
		local level = profile.current_level or 0

		local preset_name = nil
		if mod:get("random_loadout_on_character_select") and profile.character_id then
			local _, _, name = _select_random_preset_for_character(profile.character_id)
			preset_name = name
		end

		if preset_name then
			_notify(mod:localize("msg_decree_both", profile.name or "Operative", arch_title, level, preset_name))
		else
			_notify(mod:localize("msg_operative_decreed", profile.name or "Operative", arch_title, level))
		end
		return
	end

	local gm_name = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
	local is_hub = gm_name and (gm_name == "hub" or gm_name == "hub_singleplay" or gm_name == "shooting_range")

	if is_hub and mod:get("auto_reload_hub_on_switch") then
		local profiles_service = Managers.data_service and Managers.data_service.profiles
		if profiles_service and profiles_service.fetch_all_profiles then
			profiles_service:fetch_all_profiles():next(function(profile_data)
				local raw_profiles = profile_data and (profile_data.profiles or profile_data)
				local eligible = _get_eligible_profiles(raw_profiles)

				if #eligible == 0 then
					_notify(mod:localize("msg_no_eligible_operatives"))
					return
				end

				local player = Managers.player and Managers.player:local_player_safe(1)
				local current_id = player and player:character_id()
				local pool = {}

				if #eligible > 1 and current_id then
					for _, item in ipairs(eligible) do
						if item.profile.character_id ~= current_id then
							table.insert(pool, item)
						end
					end
				end

				if #pool == 0 then
					pool = eligible
				end

				local chosen = math.random_array_entry(pool)
				_switch_operative_from_hub(chosen.profile.character_id, chosen.profile)
			end)
			return
		end
	end

	_notify(mod:localize("msg_cannot_switch_operative_here"))
end

mod.reroll_loadout = function()
	local ibv = Managers.ui and Managers.ui:view_instance("inventory_background_view")
	if ibv and ibv._profile_presets_element then
		local presets = ProfileUtils.get_profile_presets()
		if not presets or #presets == 0 then
			_notify(mod:localize("msg_no_loadouts_found"))
			return
		end

		local rand_index = math.random(1, #presets)
		ibv._profile_presets_element:on_profile_preset_index_change(rand_index)

		local chosen_preset = presets[rand_index]
		local name = _get_preset_name(chosen_preset, rand_index)
		_notify(mod:localize("msg_loadout_decreed", name))
		return
	end

	local mmv = Managers.ui and Managers.ui:view_instance("main_menu_view")
	if mmv and mmv._selected_profile then
		local character_id = mmv._selected_profile.character_id
		local preset, _, name = _select_random_preset_for_character(character_id)
		if name then
			_notify(mod:localize("msg_loadout_decreed", name))
		else
			_notify(mod:localize("msg_no_loadouts_found"))
		end
		return
	end

	local gm_name = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
	local valid_gamemode = gm_name and (gm_name == "hub" or gm_name == "shooting_range")
	local player = valid_gamemode and Managers.player and Managers.player:local_player_safe(1) or nil

	if player then
		local character_id = player:character_id()
		local preset, _, name = _select_random_preset_for_character(character_id)
		if not preset then
			_notify(mod:localize("msg_no_loadouts_found"))
			return
		end

		if preset.loadout and ItemUtils and ItemUtils.equip_item_in_slot then
			for slot_name, gear_id in pairs(preset.loadout) do
				ItemUtils.equip_item_in_slot(slot_name, { gear_id = gear_id })
				Managers.event:trigger("event_inventory_view_equip_item", slot_name, { gear_id = gear_id })
			end
		end
		Managers.event:trigger("event_on_profile_preset_changed", preset)

		_notify(mod:localize("msg_loadout_decreed", name))
		return
	end

	_notify(mod:localize("msg_cannot_switch_loadout_here"))
end

mod.decree_all = function()
	local mmv = Managers.ui and Managers.ui:view_instance("main_menu_view")
	if mmv then
		mod.reroll_operative()
		return
	end

	local gm_name = Managers.state and Managers.state.game_mode and Managers.state.game_mode:game_mode_name()
	local is_hub = gm_name and (gm_name == "hub" or gm_name == "hub_singleplay" or gm_name == "shooting_range")

	if is_hub and mod:get("auto_reload_hub_on_switch") then
		mod.reroll_operative()
	else
		mod.reroll_loadout()
	end
end

mod:command("decree", mod:localize("cmd_decree_desc"), function(...)
	local args = { ... }
	local subcmd = args[1] and string.lower(args[1]) or nil

	if not subcmd or subcmd == "all" or subcmd == "roll" or subcmd == "random" or subcmd == "both" then
		mod.decree_all()
	elseif subcmd == "operative" or subcmd == "character" or subcmd == "class" or subcmd == "op" or subcmd == "char" then
		mod.reroll_operative()
	elseif subcmd == "loadout" or subcmd == "preset" or subcmd == "build" then
		mod.reroll_loadout()
	elseif subcmd == "help" then
		mod:echo(mod:localize("cmd_decree_help"))
	else
		mod:echo(mod:localize("cmd_decree_help"))
	end
end)
