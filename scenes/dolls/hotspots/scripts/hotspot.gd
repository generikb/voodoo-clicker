class_name HotSpot
extends Area2D


signal popped # When a hotspot is successfully destroyed



func take_hit(_damage) -> void:
	var mojo_reward = Global.upgrades.get_upgrade_value(Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK)
	var mojo_bonus_chance = Global.upgrades.get_upgrade_value(Util.UPGRADES.HOTSPOT_MOJO_BONUS_CHANCE)
	
	Events.spawn_mojo_drops.emit(mojo_reward, self.global_position)
	
	# check if the hit releases bonus mojo
	if randf() < mojo_bonus_chance:
		print("bonus mojo!")
		mojo_reward *= 2  #change that 2 to a mojo bonus amount later
		Events.spawn_mojo_drops.emit(mojo_reward, self.global_position)
	
	popped.emit()
	on_popped()

func on_popped() -> void:
	queue_free()
	

# Checks for manual click on hotspot
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("LeftMouseClick"):
		take_hit(1)
		
