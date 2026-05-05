extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_HEALTH = 3

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

var health = MAX_HEALTH
var is_attacking = false
var is_hit = false
var is_dead = false


func _ready() -> void:
	attack_area.monitoring = false
	print("Player health: ", health)


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity.x = 0
		move_and_slide()
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("attack") and not is_attacking and not is_hit:
		attack()
		return

	if is_attacking or is_hit:
		velocity.x = 0
		move_and_slide()
		return

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		attack_area.position.x = -abs(attack_area.position.x) if direction < 0 else abs(attack_area.position.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animation()


func update_animation() -> void:
	if is_dead or is_attacking or is_hit:
		return

	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("Jump")
		else:
			sprite.play("Fall")
	elif abs(velocity.x) > 0:
		sprite.play("Walking")
	else:
		sprite.play("Idle")


func attack() -> void:
	if is_attacking:
		return

	is_attacking = true
	velocity.x = 0

	sprite.play("Attack")
	attack_area.monitoring = true

	await get_tree().create_timer(0.15).timeout
	attack_area.monitoring = false

	await sprite.animation_finished

	is_attacking = false
	update_animation()


func take_hit(damage: int = 1) -> void:
	if is_dead or is_hit:
		return

	health -= damage
	print("Player health: ", health)

	if health <= 0:
		die()
		return

	is_hit = true
	velocity.x = 0
	sprite.play("Hit")

	await sprite.animation_finished

	is_hit = false
	update_animation()


func die() -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO
	sprite.play("Die")

	await sprite.animation_finished

	var game = get_tree().current_scene
	if game.has_method("show_death_menu"):
		game.show_death_menu()


func _on_attack_area_body_entered(body: Node2D) -> void:
	print("AttackArea touched: ", body.name)

	if body.has_method("take_damage"):
		print("Damaging: ", body.name)
		body.take_damage(999)
	else:
		print(body.name, " has no take_damage function")
