extends Area2D

@onready var slime = get_parent()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		slime.attack_player(body)
