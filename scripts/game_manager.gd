class_name GameManager
extends RefCounted


var doll_level_progress = {
	"doll_1": { "level": 1, "xp": 0 }
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func add_doll_xp(doll : DollData) -> void:
	var doll_id = doll.doll_id
	
	var current_level = doll_level_progress[doll_id]["level"]
	
	if current_level >= doll.max_level:
		return
	
	doll_level_progress[doll_id]["xp"] += 1
	
	if doll_level_progress[doll_id]["xp"] >= doll.xp_per_level:
		doll_level_progress[doll_id]["level"] += 1
		doll_level_progress[doll_id]["xp"] = 0
		Events.doll_leveled_up.emit(doll.doll_id, doll_level_progress[doll_id]["level"])
	
	
	
