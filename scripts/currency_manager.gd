class_name CurrencyMananger
extends Node

var mojo : int = 0:
	set(new_value):
		var clamped_value : int = max(0, new_value)
		if clamped_value == mojo:
			return # Exit out if the mojo didn't actually change values
		
		var old_value : int = mojo
		mojo = clamped_value
		
		#sending both values in case I want different things to happen spending vs earning
		Events.mojo_changed.emit(old_value, mojo) 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



	

func can_afford(cost: int) -> bool:
	return mojo >= cost

func spend_mojo(cost: int) -> void:
	if not can_afford(cost):
		return
	mojo -= cost

func add_mojo(amount: int) -> void:
	mojo += amount
	
