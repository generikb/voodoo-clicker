extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_test_get_mojo_pressed() -> void:
	Global.currency_manager.mojo += Global.upgrades.get_upgrade(Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK)
