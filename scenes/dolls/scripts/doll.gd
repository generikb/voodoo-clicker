class_name Doll
extends Node2D

@onready var doll_sprite: Sprite2D = %DollSprite
@onready var hotspot_markers: Node2D = %HotspotMarkers
@onready var hotspots_container: Node2D = %HotspotsContainer

var doll_data : DollData
var remaining_hotspots : Array = []
var current_hotspot : HotSpot = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Dolls get instantiated on-the-fly, this is called afterwards to set them up
func setup(data : DollData) -> void:
	doll_data = data
	doll_sprite.texture = doll_data.doll_texture
	start_minigame()
	

# Starts the pin poking minigame (varies by doll)
func start_minigame() -> void:
	remaining_hotspots = hotspot_markers.get_children()
	spawn_next_hotspot()


func spawn_next_hotspot() -> void:
	if remaining_hotspots.is_empty():
		explode_and_die()
		return
	
	var hotspot_marker : Marker2D = remaining_hotspots.pop_front()
	
	current_hotspot = doll_data.hotspot_type.instantiate()
	hotspots_container.add_child(current_hotspot)
	current_hotspot.global_position = hotspot_marker.global_position
	
	current_hotspot.popped.connect(on_hotspot_popped)

func on_hotspot_popped() -> void:
	current_hotspot = null
	spawn_next_hotspot()

# This is for the Spirit Hand to know what hotspot to click next
func get_next_target() -> HotSpot:
	return current_hotspot

func explode_and_die() -> void:
	print("You got all the hotspots!")
	queue_free()
