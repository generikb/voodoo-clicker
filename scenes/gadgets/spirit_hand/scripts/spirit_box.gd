class_name SpiritBox
extends Button

@export var spirit_hand : SpiritHand


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.




func _on_button_down() -> void:
	spirit_hand.spirit_hand_active = true


func _on_button_up() -> void:
	spirit_hand.spirit_hand_active = false


func _on_mouse_exited() -> void:
	spirit_hand.spirit_hand_active = false
