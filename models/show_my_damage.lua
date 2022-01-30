
---@class show_my_damage : module
local M = {}


--#region Constants
local tostring = tostring
local ceil = math.ceil
local random = math.random
local WHITE_COLOR = {1, 1, 1}
local YELLOW_COLOR = {1, 1, 0}
local RED_COLOR = {1, 0, 0}
local TEXT_POSITION = {0, 0}
local TEXT_DATA = {
	name = "flying-text",
	text = '',
	position = TEXT_POSITION,
	color = WHITE_COLOR
}
--#endregion


local function set_filters()
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

local function on_entity_damaged(event)
	local entity = event.entity
	if not (entity and entity.valid) then return end
	local damage = ceil(event.final_damage_amount)
	TEXT_DATA.text = tostring(damage)
	local ent_pos = entity.position
	TEXT_POSITION[1] = ent_pos.x + random() - 0.5
	TEXT_POSITION[2] = ent_pos.y + random() - 0.5
	if damage > 50 then
		if damage > 200 then
			TEXT_DATA.color = RED_COLOR
		else
			TEXT_DATA.color = YELLOW_COLOR
		end
	else
		TEXT_DATA.color = WHITE_COLOR
	end
	entity.surface.create_entity(TEXT_DATA)
end

local function on_runtime_mod_setting_changed(event)
	if string.sub(event.setting, 0, 4) == "SMD_" then
		set_filters()
	end
end

--#endregion


--#region Pre-game stage

local function add_remote_interface()
	-- https://lua-api.factorio.com/latest/LuaRemote.html
	remote.remove_interface("show_my_damage") -- For safety
	remote.add_interface("show_my_damage", {})
end


M.on_init = set_filters
M.on_configuration_changed = set_filters
M.on_load = set_filters
M.add_remote_interface = add_remote_interface
M.on_mod_enabled = set_filters
-- M.on_mod_disabled = set_filters

--#endregion


M.events = {
	[defines.events.on_entity_damaged] = on_entity_damaged,
	[defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
}


return M
