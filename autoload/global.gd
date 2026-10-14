extends Node

var upgrades : Upgrades
var currency_manager : CurrencyManager
var game_manager : GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()





func new_game() -> void:
	upgrades = Upgrades.new()
	currency_manager = CurrencyManager.new()
	game_manager = GameManager.new()
