class_name FingerHotSpot
extends HotSpot


var can_be_hit : bool = true

# Slightly modified to give a delay so the player can't accidentally overhit it
func take_hit(damage : int) -> void:
	if not can_be_hit:
		return
	
	can_be_hit = false
	
	super.take_hit(damage) # calls the base take_hit function
	get_tree().create_timer(0.2).timeout.connect(func(): can_be_hit = true)


# We want the finger hotspot to not be destroyed when hit
func on_popped() -> void:
	pass
