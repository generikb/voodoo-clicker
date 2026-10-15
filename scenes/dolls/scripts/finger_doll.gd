class_name FingerDoll
extends Node2D

@onready var finger_doll_manager: Node2D = %FingerDollManager
@onready var finger_hot_spot: FingerHotSpot = %FingerHotSpot

@onready var static_target_marker: Area2D = %StaticTargetMarker

var freak_out_multiplier : float = 0.0
var decay_rate : float = 0.5

var base_distance : float = 20.0
var base_duration : float = 1.0
var freak_out_tween : Tween = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if freak_out_multiplier > 0.0:
		freak_out_multiplier = move_toward(freak_out_multiplier, 0.0, decay_rate * delta)



func _on_static_target_marker_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftMouseClick"):
		if static_target_marker.overlaps_area(finger_hot_spot):
			finger_hot_spot.take_hit(1)
			freak_out_multiplier = clamp(freak_out_multiplier + 1.0, 0.0, 5.0)
			finger_freak_out()
		else:
			print("you missed!")


func finger_freak_out() -> void:
	if freak_out_multiplier <= 0.0:
		if freak_out_tween:
			freak_out_tween.kill()
		freak_out_tween = create_tween()
		freak_out_tween.tween_property(finger_doll_manager, "position", Vector2.ZERO, 0.2)
		return
	
	var distance = base_distance * freak_out_multiplier
	var duration = base_duration / (1.0 + freak_out_multiplier * 0.7)
	
	
	var current_pos = finger_doll_manager.position
	var new_angle : float
	
	if current_pos.length() < 5.0:
		new_angle = randf() * TAU
	else:
		if randf() < 0.5: # slice through center
			new_angle = current_pos.angle() + PI + randf_range(-PI * 0.25, PI * 0.25)
		else:
			var side = 1.0 if randf() < 0.5 else -1.0
			new_angle = current_pos.angle() + randf_range(PI * 0.35, PI * 0.65) * side

	var target_pos = Vector2.from_angle(new_angle) * (distance * randf_range(0.8, 1.2))
	
	if freak_out_tween:
		freak_out_tween.kill()
	
	freak_out_tween = create_tween()
	freak_out_tween.tween_property(finger_doll_manager, "position", target_pos, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	freak_out_tween.tween_callback(finger_freak_out)
	
