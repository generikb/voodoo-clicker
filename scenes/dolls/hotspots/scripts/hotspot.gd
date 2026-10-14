class_name HotSpot
extends Area2D


signal popped # When a hotspot is successfully destroyed



func take_hit(_damage) -> void:
	var mojo_reward = Global.upgrades.get_upgrade_value(Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK)
	var mojo_bonus_chance = Global.upgrades.get_upgrade_value(Util.UPGRADES.HOTSPOT_MOJO_BONUS_CHANCE)
	
	# check if the hit releases bonus mojo
	if randf() < mojo_bonus_chance:
		mojo_reward *= 2  #change that 2 to a mojo bonus amount later
	
	Global.currency_manager.add_mojo(mojo_reward)
	popped.emit()
	queue_free()
	

# Checks for manual click on hotspot
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftMouseClick"):
		take_hit(1)
		
