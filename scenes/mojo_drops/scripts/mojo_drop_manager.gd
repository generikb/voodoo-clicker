class_name MojoDropManager
extends Node2D

var mojo_drop_scene = preload("uid://doly467ek8t8f")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.spawn_mojo_drops.connect(spawn_mojo_drops)


# Mojo bits get vacuumed up by the mouse cursor
func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	for mojo_drop : MojoDrop in self.get_children():
		var dist = mojo_drop.global_position.distance_to(mouse_pos)
		if dist < 60.0 and mojo_drop.can_pick_up:
			mojo_drop.is_magnetized = true
		if dist < 15.0 and mojo_drop.can_pick_up:
			mojo_drop.is_magnetized = false
			Global.currency_manager.add_mojo(mojo_drop.value)
			mojo_drop.queue_free()

# spawns between 3-6 mojo bits (to prevent performance hits)
func spawn_mojo_drops(total_mojo : int, spawn_pos : Vector2) -> void:
	if total_mojo <= 0:
		return
	
	var drop_count : int = min(total_mojo, randi_range(3, 6))
	var base_value : int = total_mojo / drop_count
	var remainder : int = total_mojo % drop_count
	
	for i in drop_count:
		var drop_value : int = base_value + (1 if i < remainder else 0)
		var drop_texture : Texture2D = get_drop_texture_by_value(drop_value)
		spawn_mojo_drop(drop_texture, drop_value, spawn_pos)


func get_drop_texture_by_value(amount : int) -> Texture2D:
	# we'll update this with multiple textures later
	return preload("uid://bpkpx37jxddx2")


func spawn_mojo_drop(drop_texture : Texture2D, drop_amount : int, spawn_pos : Vector2) -> void:
	var new_mojo_drop : MojoDrop = mojo_drop_scene.instantiate()
	self.add_child(new_mojo_drop)
	new_mojo_drop.sprite_2d.texture = drop_texture
	new_mojo_drop.value = drop_amount
	
	new_mojo_drop.launch(spawn_pos)
	
