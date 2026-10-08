class_name Upgrades
extends Node


var upgrades_dict = {
	Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK: 1
	
}


# Returns the value of a specific Upgrade in the dictionary
func get_upgrade(upgrade: Util.UPGRADES):
	return upgrades_dict.get(upgrade, null)

# Overwrites the value of a specific Upgrade in the dictonary
func set_upgrade(upgrade: Util.UPGRADES, new_value):
	var old_value = upgrades_dict[upgrade]
	upgrades_dict[upgrade] = new_value
	
	Events.mod_changed.emit(upgrade, old_value, new_value)

# Changes the amount of a specific Upgrade in the dictionary (i.e. incremental changes)
func change_upgrade(upgrade: Util.UPGRADES, amount):
	var old_value = upgrades_dict[upgrade]
	upgrades_dict[upgrade] += amount
	
	Events.mod_changed.emit(upgrade, old_value, upgrades_dict[upgrade])
