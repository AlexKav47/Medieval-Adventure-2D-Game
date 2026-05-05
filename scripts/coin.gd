extends Area2D

@onready var coin_sound: AudioStreamPlayer2D = $CoinSound
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var collected = false


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return

	if body.is_in_group("player"):
		collected = true

		var game = get_tree().current_scene
		if game.has_method("add_coin"):
			game.add_coin()

		collision_shape.set_deferred("disabled", true)
		visible = false

		if coin_sound:
			coin_sound.play()
			await coin_sound.finished

		queue_free()
