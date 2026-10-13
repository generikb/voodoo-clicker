class_name Upgrades
extends RefCounted

@export var all_upgrades : Array[UpgradeData] = [
	preload("res://resources/upgrades/mojo_per_hotspot.tres"),
	preload("res://resources/upgrades/hotspot_bonus_mojo_chance.tres")
	
	

]

var upgrades_database : Dictionary = {}

var player_levels = {}

func _init() -> void:
	# Build lookup dictionary from all_upgrades Array
	for data in all_upgrades:
		upgrades_database[data.upgrade_id] = data
		if not player_levels.has(data.upgrade_id):
			player_levels[data.upgrade_id] = 0

func get_upgrade_value(upgrade_id: Util.UPGRADES) -> float:
	var data: UpgradeData = upgrades_database.get(upgrade_id)
	if data == null:
		return 0
	var current_level = get_upgrade_level(upgrade_id)
	return data.get_boost(current_level)


# Returns the level of a specific Upgrade in the dictionary
func get_upgrade_level(upgrade_id: Util.UPGRADES) -> int:
	return player_levels.get(upgrade_id, 0)

# Checks if prereq is met to show the upgrade node
func is_unlocked(data : UpgradeData) -> bool:
	if data.prereq_upgrade == null:
		return true
	return get_upgrade_level(data.prereq_upgrade.upgrade_id) >= data.prereq_level

# Attempts to purchase (or level up) an upgrade
func purchase_upgrade(data : UpgradeData) -> bool:
	var current_level = get_upgrade_level(data.upgrade_id)

	# Don't purchase if already at max level or still locked
	if current_level >= data.max_level or not is_unlocked(data):
		print("level check failed")
		return false
	
	var cost = data.get_cost(current_level)
	
	# Purchase if player has enough mojo
	if Global.currency_manager.can_afford(cost):
		player_levels[data.upgrade_id] = current_level + 1
		Global.currency_manager.spend_mojo(cost)
		print("Level has been updated to: " , player_levels[data.upgrade_id])
		return true
	
	return false

# Counts the number of upgrades available for purchase with the current mojo amount
func get_affordable_upgrade_count() -> int:
	var count = 0
	for data : UpgradeData in all_upgrades:
		var current_level = get_upgrade_level(data.upgrade_id)
		var cost = data.get_cost(current_level)
		if current_level < data.max_level and is_unlocked(data) and Global.currency_manager.can_afford(cost):
			count += 1
	return count
