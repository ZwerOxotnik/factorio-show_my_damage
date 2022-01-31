
---@class show_my_damage : module
local M = {}


local core = require("models/SMD_core")


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


--#region Functions of events

local function on_entity_damaged(event)
	local entity = event.entity
	if not (entity and entity.valid) then return end

	local damage = ceil(event.final_damage_amount)
	TEXT_DATA.text = tostring(damage)
	local ent_pos = entity.position
	TEXT_POSITION[1] = ent_pos.x + random() - 0.5
	TEXT_POSITION[2] = ent_pos.y + random() - 0.5
	if damage > 30 then
		if damage > 100 then
			TEXT_DATA.color = RED_COLOR
		else
			TEXT_DATA.color = YELLOW_COLOR
		end
	else
		TEXT_DATA.color = WHITE_COLOR
	end

	entity.surface.create_entity(TEXT_DATA)
end

--#endregion


--#region Pre-game stage

M.on_init = core.set_filters
M.on_configuration_changed = core.set_filters
M.on_load = core.set_filters
M.add_remote_interface = core.add_remote_interface
M.on_mod_enabled = core.set_filters
-- M.on_mod_disabled = core.set_filters

--#endregion


M.events = {
	[defines.events.on_entity_damaged] = on_entity_damaged,
	[defines.events.on_runtime_mod_setting_changed] = core.on_runtime_mod_setting_changed
}


return M
