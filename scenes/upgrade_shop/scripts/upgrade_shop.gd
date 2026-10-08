class_name UpgradeShop
extends Control

var slide_tween: Tween
var is_open : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = get_viewport_rect().size.y
	self.hide()
	Events.toggle_upgrade_shop.connect(toggle_shop)


func toggle_shop() -> void:
	if is_open:
		close_shop()
	else:
		open_shop()


func open_shop() -> void:
	is_open = true
	self.show()
	
	if slide_tween:
		slide_tween.kill()
	slide_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	var target_y = get_viewport_rect().size.y - size.y
	slide_tween.tween_property(self, "position:y", target_y, 1.0)


func close_shop() -> void:
	is_open = false
	
	if slide_tween:
		slide_tween.kill()
	slide_tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	var offscreen_y = get_viewport_rect().size.y
	slide_tween.tween_property(self, "position:y", offscreen_y, 1.0)
	slide_tween.tween_callback(self.hide)


func _on_temp_upgrade_mojo_per_click_pressed() -> void:
	Global.upgrades.change_upgrade(Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK, 1)
	print("Mojo per click increased by 1. Total Mojo per click is: ", str(Global.upgrades.get_upgrade(Util.UPGRADES.BASE_HOTSPOT_MOJO_PER_CLICK)))
