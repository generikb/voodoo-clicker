extends Node2D

@export var temp_doll : DollData

@onready var doll_spot: Marker2D = %DollSpot
@onready var mojo_drop_manager: MojoDropManager = %MojoDropManager
@onready var finger_doll: FingerDoll = %FingerDoll


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

#func _process(_delta: float) -> void:
	#var mouse_pos = get_global_mouse_position()
	#for mojo_drop : MojoDrop in mojo_drop_manager.get_children():
		#if mojo_drop.global_position.distance_to(mouse_pos) < 60.0 and mojo_drop.can_pick_up:
			#mojo_drop.is_magnetized = true
		#if mojo_drop.global_position.distance_to(mouse_pos) < 5.0 and mojo_drop.can_pick_up:
			#Global.currency_manager.add_mojo(mojo_drop.value)
			#mojo_drop.queue_free()




func _on_spawn_doll_button_pressed() -> void:
	var new_doll : Doll = temp_doll.doll_type.instantiate()
	doll_spot.add_child(new_doll)
	new_doll.setup(temp_doll)


func _on_spawn_finger_button_toggled(toggled_on: bool) -> void:
	finger_doll.visible = toggled_on
