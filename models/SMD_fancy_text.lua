
---@class show_my_damage : module
local M = {}


local core = require("models/SMD_core")


--#region Constants
local tostring = tostring
local ceil = math.ceil
local random = math.random
local draw_text = rendering.draw_text
local WHITE_COLOR = {1, 1, 1}
local YELLOW_COLOR = {1, 1, 0}
local RED_COLOR = {1, 0, 0}
local TEXT_OFFSET = {0, 0}
local TEXT_DATA = {
	name = "flying-text",
	text = '',
	target = nil,
	surface = nil,
	scale = 1,
	time_to_live = 15,
	color = WHITE_COLOR,
	target_offset = TEXT_OFFSET,
	only_in_alt_mode = true
}
--#endregion


--#region Functions of events

local function on_entity_damaged(event)
	local entity = event.entity
	if not (entity and entity.valid) then return end

	TEXT_DATA.target = entity
	TEXT_DATA.surface = entity.surface

	local damage = ceil(event.final_damage_amount)
	TEXT_DATA.text = tostring(damage)
	if damage > 30 then
		local scale = 1.5
		if damage > 100 then
			scale = damage / 50
			if scale > 2.5 then
				TEXT_DATA.scale = 2.5
			else
				TEXT_DATA.scale = scale
			end
			TEXT_DATA.time_to_live = 60
			TEXT_DATA.color = RED_COLOR
		else
			TEXT_DATA.scale = scale
			TEXT_DATA.time_to_live = 40
			TEXT_DATA.color = YELLOW_COLOR
		end
	else
		TEXT_DATA.scale = 1
		TEXT_DATA.time_to_live = 20
		TEXT_DATA.color = WHITE_COLOR
	end
	TEXT_OFFSET[1] = random() * 1.5 - 0.75
	TEXT_OFFSET[2] = random() * 1.5 - 0.75

	draw_text(TEXT_DATA)
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
