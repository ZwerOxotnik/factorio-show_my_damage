---@type table<string, module>
local modules = {}
modules.show_my_damage = require("models/show_my_damage")


-- Safe disabling of this mod remotely on init stage
-- Useful for other map developers and in some rare cases for mod devs
if remote.interfaces["disable-" .. script.mod_name] then
	for _, module in pairs(modules) do
		module.events = nil
		module.on_nth_tick = nil
		module.commands = nil
		module.on_load = nil
		module.add_remote_interface = nil
		module.add_commands = nil
	end
-- else
-- 	modules.better_commands:handle_custom_commands(modules.example_module) -- adds commands
end


local event_handler
if script.active_mods["switchable_mods"] then
	event_handler = require("__switchable_mods__/event_handler_vSM")
else
	if script.active_mods["zk-lib"] then
		-- Same as Factorio "event_handler", but slightly better performance
		event_handler = require("__zk-lib__/static-libs/lualibs/event_handler_vZO.lua")
	else
		event_handler = require("event_handler")
	end
end

event_handler.add_libraries(modules)
