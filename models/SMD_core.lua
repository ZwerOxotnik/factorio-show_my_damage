
---@class show_my_damage : module
local M = {}


local sub = string.sub


M.set_filters = function()
	local filters = {
		{
			filter = "final-damage-amount", comparison = ">",
			value = settings.global["SMD_minimum_damage"].value,
			mode = "and"
		}
	}

	if settings.global["SMD_ignore_damage_on_walls"].value then
		table.insert(filters, {filter = "type", type = "wall", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_damage_on_gates"].value then
		table.insert(filters, {filter = "type", type = "gate", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_damage_on_tree"].value then
		table.insert(filters, {filter = "type", type = "tree", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_damage_on_units"].value then
		table.insert(filters, {filter = "type", type = "unit", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_damage_on_characters"].value then
		table.insert(filters, {filter = "type", type = "character", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_damage_on_simple_entities"].value then
		table.insert(filters, {filter = "type", type = "simple-entity", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_fire_damage"].value then
		table.insert(filters, {filter = "damage-type", type = "fire", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_acid_damage"].value then
		table.insert(filters, {filter = "damage-type", type = "acid", invert = true, mode = "and"})
	end
	if settings.global["SMD_ignore_physical_damage"].value then
		table.insert(filters, {filter = "damage-type", type = "physical", invert = true, mode = "and"})
	end

	script.set_event_filter(defines.events.on_entity_damaged, filters)
end


--#region Functions of events

M.on_runtime_mod_setting_changed = function(event)
	if sub(event.setting, 0, 4) == "SMD_" then
		M.set_filters()
	end
end

--#endregion


--#region Pre-game stage

M.add_remote_interface = function()
	-- https://lua-api.factorio.com/latest/LuaRemote.html
	remote.remove_interface("show_my_damage") -- For safety
	remote.add_interface("show_my_damage", {})
end

--#endregion


return M
