class_name FingerHotSpot
extends HotSpot


var can_be_hit : bool = true

func take_hit(damage : int) -> void:
	if not can_be_hit:
		return
	
	can_be_hit = false
	
	super.take_hit(damage)
	get_tree().create_timer(0.2).timeout.connect(func(): can_be_hit = true)


func on_popped() -> void:
	pass
