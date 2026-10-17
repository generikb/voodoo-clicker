class_name SpiritHand
extends Node2D

@export var doll_spot : Marker2D
@export var base_movement_speed : float = 500.0 # Pixels per second

var can_miss : bool = true

var spirit_hand_active : bool = false :
	set(new_value):
		spirit_hand_active = new_value
		if spirit_hand_active:
			spirit_hand_on()
		else:
			spirit_hand_off()

var starting_position : Vector2
var hand_tween : Tween

func _ready() -> void:
	starting_position = global_position


func spirit_hand_on() -> void:
	auto_poke()
	
func auto_poke() -> void:
	if not spirit_hand_active:
		return
	
	var current_doll : Doll = get_active_doll()
	if current_doll == null:
		get_tree().create_timer(0.5).timeout.connect(auto_poke)
		return
		
	var current_hotspot : HotSpot = current_doll.get_next_target()
	if current_hotspot == null:
		get_tree().create_timer(0.2).timeout.connect(auto_poke)
		return
		
	if hand_tween:
		hand_tween.kill()
	
	hand_tween = create_tween()
	
	# sets a consistent speed based on spirit hand speed upgrade value (d = r * t)
	var speed_multipier : float = Global.upgrades.get_upgrade_value(Util.UPGRADES.SPIRIT_HAND_SPEED)
	var current_speed : float = base_movement_speed * speed_multipier
	
	var distance : float = self.global_position.distance_to(current_hotspot.global_position)
	var move_duration : float = maxf(0.1, distance / current_speed)
	
	# sets accuracy based on spirit hand accuracy upgrade value and determines if hit or not
	var accuracy : float = Global.upgrades.get_upgrade_value(Util.UPGRADES.SPIRIT_HAND_ACCURACY)
	
	var is_hit = randf() <= accuracy or not can_miss
	
	if is_hit:	
		hand_tween.tween_property(self, "global_position", current_hotspot.global_position, move_duration)
		hand_tween.tween_callback(current_hotspot.take_hit.bind(1))
		hand_tween.tween_interval(0.3 / speed_multipier)
		hand_tween.tween_callback(func(): can_miss = true)
		hand_tween.tween_callback(auto_poke)
		
	
	else:
		var approach_pos = global_position.lerp(current_hotspot.global_position, 0.9)
		var miss_pos = get_miss_position(current_hotspot.global_position)
		
		hand_tween.tween_property(self, "global_position", approach_pos, move_duration)
		hand_tween.tween_property(self, "global_position", miss_pos, .1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		hand_tween.tween_callback(func(): Events.spirit_hand_missed.emit())
		hand_tween.tween_interval(0.5)
		hand_tween.tween_callback(func(): can_miss = false) # sets it so you can only miss once per hotspot
		hand_tween.tween_callback(auto_poke)
		print("you missed!")
	
	

func spirit_hand_off() -> void:
	if hand_tween:
		hand_tween.kill()
	
	hand_tween = create_tween()
	hand_tween.tween_property(self, "global_position", starting_position, 1.0)

func get_active_doll() -> Doll:
	if doll_spot and doll_spot.get_child_count() > 0:
		return doll_spot.get_child(0) as Doll
	return null

func get_miss_position(target_pos: Vector2) -> Vector2:
	var hand_direction = self.global_position.direction_to(target_pos)
	var miss_direction = hand_direction.rotated(randf_range(-0.6, 0.6))
	var miss_distance = randf_range(20.0, 35.0)
	return target_pos + (miss_direction * miss_distance)
