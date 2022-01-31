-- See https://wiki.factorio.com/Tutorial:Mod_settings#Reading_settings


-- https://wiki.factorio.com/Tutorial:Mod_settings#Creation
data:extend({
	{
			type = "string-setting",
			name = "SMD_mode",
			setting_type = "startup",
			allowed_values = {"fancy_text", "simple_floating_text"},
			default_value = "fancy_text",
	},
	{
			type = "int-setting",
			name = "SMD_minimum_damage",
			setting_type = "runtime-global",
			minimum_value = -100000000,
			maximum_value = 100000000,
			default_value = 0,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_walls",
			setting_type = "runtime-global",
			default_value = true,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_gates",
			setting_type = "runtime-global",
			default_value = true,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_characters", -- players
			setting_type = "runtime-global",
			default_value = false,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_units",
			setting_type = "runtime-global",
			default_value = false,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_simple_entities",
			setting_type = "runtime-global",
			default_value = false,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_damage_on_tree",
			setting_type = "runtime-global",
			default_value = true,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_fire_damage",
			setting_type = "runtime-global",
			default_value = true,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_acid_damage",
			setting_type = "runtime-global",
			default_value = true,
	},
	{
			type = "bool-setting",
			name = "SMD_ignore_physical_damage",
			setting_type = "runtime-global",
			default_value = false,
	},
})
