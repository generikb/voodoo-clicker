class_name DollData
extends Resource

@export var doll_id : String
@export var doll_name : String
@export var doll_texture : Texture

@export_group("Mojo & XP Leveling Data")
@export var base_mojo_reward : int = 10
@export var max_level : int = 10
@export var xp_per_level : int = 5

@export_group("")
@export var doll_type : PackedScene = preload("uid://b1rrd0kqlf37k") #defaults to Base Doll
@export var hotspot_type : PackedScene
