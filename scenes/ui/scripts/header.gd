class_name HeaderUI
extends Control

@onready var mojo_label: Label = $PanelContainer/HBoxContainer/MojoLabel

@onready var temp_shop: Button = %TempShop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.mojo_changed.connect(update_mojo_ui)
	Events.mojo_changed.connect(update_shop_button.unbind(2))



	
func update_mojo_ui(_old_value : int, mojo : int) -> void:
	mojo_label.text = str(mojo)

func update_shop_button() -> void:
	var affordable_upgrades : int = Global.upgrades.get_affordable_upgrade_count()
	temp_shop.text = str("Upgrade Shop (%d)" % affordable_upgrades)

func _on_temp_shop_pressed() -> void:
	Events.toggle_upgrade_shop.emit()
