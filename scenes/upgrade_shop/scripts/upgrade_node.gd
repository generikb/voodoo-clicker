class_name UpgradeNode
extends TextureButton

@export var upgrade_data : UpgradeData
@export var prereq_node : UpgradeNode

@onready var level_label: Label = %LevelLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# in case I accidentally forget to add a resource!
	if upgrade_data == null:
		push_error("Upgrade Node '%s' is missing the UpgradeData resource!" % name)
		return
	
	self.texture_normal = upgrade_data.upgrade_icon
	refresh_node()


func refresh_node() -> void:
	var current_level = Global.upgrades.get_upgrade_level(upgrade_data.upgrade_id)
	tooltip_text = upgrade_data.get_tooltip(current_level)
	# Check if unlocked and affordable
	var is_unlocked = Global.upgrades.is_unlocked(upgrade_data)
	visible = is_unlocked
	disabled = current_level >= upgrade_data.max_level or not Global.currency_manager.can_afford(upgrade_data.get_cost(current_level))


func _on_pressed() -> void:
	if Global.upgrades.purchase_upgrade(upgrade_data):
		refresh_node()
