extends Node

enum GAME_STAGES{
	MAIN_MENU,
	PLAYING
}

enum UPGRADE_TYPES{
	ADD, # base + (boost * level)
	MULTIPLY # base + pow(boost, level)
}

enum UPGRADES{
	# Hotspot Upgrades
	BASE_HOTSPOT_MOJO_PER_CLICK,
	HOTSPOT_MOJO_BONUS_CHANCE,
	# Spirit Hand Upgrades
	SPIRIT_HAND_UNLOCKED,
	SPIRIT_HAND_SPEED,
	SPIRIT_HAND_ACCURACY
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
