class_name HeaderUI
extends Control

@onready var mojo_label: Label = $PanelContainer/HBoxContainer/MojoLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.mojo_changed.connect(update_mojo_ui)



	
func update_mojo_ui(_old_value : int, mojo : int) -> void:
	mojo_label.text = str(mojo)


func _on_temp_shop_pressed() -> void:
	Events.toggle_upgrade_shop.emit()
