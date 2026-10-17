class_name MojoDrop
extends Node2D


@onready var sprite_2d: Sprite2D = $Sprite2D

var value : int = 0
var can_pick_up : bool = false # pickup delay after it initially spawns

var is_magnetized : bool = false
var magnet_speed : float = 300.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if is_magnetized:
		var mouse_pos = get_global_mouse_position()
		
		magnet_speed += 500.0 * delta #speeds up over time, cool effect
		
		self.global_position = self.global_position.move_toward(mouse_pos, magnet_speed * delta)


func launch(from_pos : Vector2) -> void:
	self.global_position = from_pos
	
	var random_angle = randf() * TAU
	var distance = randf_range(30.0, 70.0)
	var target_land_pos = from_pos + Vector2.from_angle(random_angle) * distance
	
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", target_land_pos, 0.4)
	tween.tween_callback(func() : can_pick_up = true)
