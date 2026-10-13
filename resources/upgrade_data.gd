class_name UpgradeData
extends Resource


@export_group("Upgrade UI Info")
@export var upgrade_id : Util.UPGRADES
@export var upgrade_name : String
@export var upgrade_description : String
@export var upgrade_icon : Texture2D

@export_group("Cost Scaling")
@export var base_cost : float = 69
@export var cost_multiplier : float = 1.15

@export_group("Upgrade Scaling")
@export var max_level : int
@export var upgrade_type : Util.UPGRADE_TYPES
@export var base_value : float = 1.0
@export var boost_per_level: float = 1.0

@export_group("Tech Tree Info")
@export var prereq_upgrade : UpgradeData = null # What Upgrade Node needs to be unlocked first
@export var prereq_level : int = 1 # What level the prereq needs to be
@export var tooltip_suffix : String = ""

func get_boost(level : int) -> float:
	match upgrade_type:
		Util.UPGRADE_TYPES.ADD:
			return base_value + (boost_per_level * level)
		Util.UPGRADE_TYPES.MULTIPLY:
			if level == 0:
				return base_value
			return base_value * pow(boost_per_level, level)
	return 0.0

# Cost is always expontential equation
func get_cost(current_level : int) -> int:
	return int(base_cost * pow(cost_multiplier, current_level))

func get_tooltip(current_level : int) -> String:
	var current_value = get_boost(current_level)
	var next_value = get_boost(current_level + 1)
	
	return "%s\n%s\n%.1f%s -> %.1f%s\nCost: %1.f" % [
		upgrade_name,
		upgrade_description,
		current_value, tooltip_suffix,
		next_value, tooltip_suffix,
		get_cost(current_level)
	]
