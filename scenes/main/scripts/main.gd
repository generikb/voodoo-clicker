extends Node2D

@export var temp_doll : DollData

@onready var doll_spot: Marker2D = %DollSpot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass





func _on_spawn_doll_button_pressed() -> void:
	var new_doll : Doll = temp_doll.doll_type.instantiate()
	doll_spot.add_child(new_doll)
	new_doll.setup(temp_doll)
