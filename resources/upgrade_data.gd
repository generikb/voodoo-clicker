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
@export var max_rank : int
@export var upgrade_type : Util.UPGRADE_TYPES
@export var base_value : float = 1.0
@export var boost_per_rank: float = 1.0


func get_boost(level : int) -> float:
	print("get boost is firing")
	match upgrade_type:
		Util.UPGRADE_TYPES.ADD:
			print("and it's an add upgrade")
			return base_value + (boost_per_rank * level)
		Util.UPGRADE_TYPES.MULTIPLY:
			if level == 0:
				return base_value
			return base_value * pow(boost_per_rank, level)
	return 0.0
