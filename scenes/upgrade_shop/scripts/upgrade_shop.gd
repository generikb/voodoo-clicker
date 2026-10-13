class_name UpgradeShop
extends Control

@onready var upgrade_nodes: Control = %UpgradeNodes

var slide_tween: Tween
var is_open : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.y = get_viewport_rect().size.y
	self.hide()
	Events.toggle_upgrade_shop.connect(toggle_shop)
	Events.mojo_changed.connect(refresh_shop.unbind(2))
	upgrade_nodes.draw.connect(_draw_upgrade_lines)


func _draw_upgrade_lines() -> void:
	for node in upgrade_nodes.get_children():
		if node is UpgradeNode and node.prereq_node != null and node.visible:
			var start = node.position + node.size / 2
			var end = node.prereq_node.position + node.prereq_node.size / 2
			upgrade_nodes.draw_line(start, end, Color.LIME, 5.0)


func toggle_shop() -> void:
	if is_open:
		close_shop()
	else:
		open_shop()


func open_shop() -> void:
	
	is_open = true
	self.show()
	
	refresh_shop()
	
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

func refresh_shop() -> void:
	if is_open:
		for upgrade_node in upgrade_nodes.get_children():
			if upgrade_node is UpgradeNode:
				upgrade_node.refresh_node()
	upgrade_nodes.queue_redraw()
