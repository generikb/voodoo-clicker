extends Node

var upgrades : Upgrades
var currency_manager : CurrencyMananger

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func new_game() -> void:
	upgrades = Upgrades.new()
	currency_manager = CurrencyMananger.new()
