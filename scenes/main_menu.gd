extends Control

@onready var play_button: Button = $Button
@onready var exit_button: Button = $ExitButton
@onready var tap_sound = $TapSound


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)


func _on_play_button_pressed() -> void:
	print("Play button pressed")

	if tap_sound:
		tap_sound.play()
		await get_tree().create_timer(0.2).timeout

	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_button_pressed() -> void:
	print("Exit button pressed")

	if tap_sound:
		tap_sound.play()
		await get_tree().create_timer(0.2).timeout

	get_tree().quit()
