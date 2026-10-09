class_name Upgrades
extends RefCounted

@export var all_upgrades : Array[UpgradeData] = [
	preload("res://resources/upgrades/mojo_per_hotspot.tres")

]

var upgrades_database : Dictionary = {}

var player_levels = {
	Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK : 0
}

func _init() -> void:
	# Build lookup dictionary from all_upgrades Array
	for data in all_upgrades:
		upgrades_database[data.upgrade_id] = data
		if not player_levels.has(data.upgrade_id):
			player_levels[data.upgrade_id] = 0


# Returns the value of a specific Upgrade in the dictionary
func get_upgrade(upgrade: Util.UPGRADES):
	var data : UpgradeData = upgrades_database.get(upgrade)
	if data == null:
		return 0
	
	var current_level = player_levels.get(upgrade, 0)
	
	return data.get_boost(current_level)

## Overwrites the value of a specific Upgrade in the dictonary
#func set_upgrade(upgrade: Util.UPGRADES, new_value):
	#var old_value = upgrades_dict[upgrade]
	#upgrades_dict[upgrade] = new_value
	#
	#Events.mod_changed.emit(upgrade, old_value, new_value)
#
## Changes the amount of a specific Upgrade in the dictionary (i.e. incremental changes)
#func change_upgrade(upgrade: Util.UPGRADES, amount):
	#var old_value = upgrades_dict[upgrade]
	#upgrades_dict[upgrade] += amount
	#
	#Events.mod_changed.emit(upgrade, old_value, upgrades_dict[upgrade])
