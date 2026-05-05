extends Node2D

const TOTAL_COINS = 10

@onready var coin_label: Label = $"CanvasLayer/CoinLabel"
@onready var end_menu: Control = $CanvasLayer/EndMenu
@onready var result_label: Label = $CanvasLayer/EndMenu/Panel/ResultLabel
@onready var play_again_button: Button = $CanvasLayer/EndMenu/Panel/PlayAgainButton
@onready var main_menu_button: Button = $CanvasLayer/EndMenu/Panel/MainMenuButton
@onready var exit_button: Button = $CanvasLayer/EndMenu/Panel/ExitButton

var coins_collected = 0
var game_ended = false


func _ready() -> void:
	end_menu.visible = false
	update_coin_label()

	play_again_button.pressed.connect(_on_play_again_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)
	exit_button.pressed.connect(_on_exit_pressed)


func add_coin() -> void:
	if game_ended:
		return

	coins_collected += 1
	update_coin_label()

	if coins_collected >= TOTAL_COINS:
		show_win_menu()


func update_coin_label() -> void:
	coin_label.text = "Coins %d/%d" % [coins_collected, TOTAL_COINS]


func show_win_menu() -> void:
	show_end_menu("You Win!\nCoins collected: %d/%d" % [coins_collected, TOTAL_COINS])


func show_death_menu() -> void:
	show_end_menu("Game Over\nCoins collected: %d/%d" % [coins_collected, TOTAL_COINS])


func show_end_menu(message: String) -> void:
	if game_ended:
		return

	game_ended = true
	result_label.text = message
	end_menu.visible = true

	get_tree().paused = true
	end_menu.process_mode = Node.PROCESS_MODE_ALWAYS


func _on_play_again_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
