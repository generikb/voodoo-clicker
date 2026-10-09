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
	BASE_HOTSPOT_MOJO_PER_CLICK
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
