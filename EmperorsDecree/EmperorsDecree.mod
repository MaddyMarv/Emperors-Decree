return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`EmperorsDecree` encountered an error loading the Darktide Mod Framework.")

		new_mod("EmperorsDecree", {
			mod_script       = "EmperorsDecree/scripts/mods/EmperorsDecree/EmperorsDecree",
			mod_data         = "EmperorsDecree/scripts/mods/EmperorsDecree/EmperorsDecree_data",
			mod_localization = "EmperorsDecree/scripts/mods/EmperorsDecree/EmperorsDecree_localization",
		})
	end,
	packages = {},
}
