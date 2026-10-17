class_name SpiritBox
extends Button

@export var spirit_hand : SpiritHand


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.upgrade_purchased.connect(_on_upgrade_purchased)
	update_visibility()


func _on_upgrade_purchased(upgrade_id : Util.UPGRADES) -> void:
	if upgrade_id == Util.UPGRADES.SPIRIT_HAND_UNLOCKED:
		update_visibility()

func update_visibility() -> void:
	var is_unlocked : bool = Global.upgrades.get_upgrade_level(Util.UPGRADES.SPIRIT_HAND_UNLOCKED) > 0
	visible = is_unlocked
	if spirit_hand:
		spirit_hand.visible = is_unlocked

func _on_button_down() -> void:
	spirit_hand.spirit_hand_active = true


func _on_button_up() -> void:
	spirit_hand.spirit_hand_active = false


func _on_mouse_exited() -> void:
	spirit_hand.spirit_hand_active = false
