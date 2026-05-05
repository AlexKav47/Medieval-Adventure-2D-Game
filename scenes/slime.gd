extends CharacterBody2D

const SPEED = 60.0
const GRAVITY = 900.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var floor_check: RayCast2D = $FloorCheck
@onready var wall_check: RayCast2D = $WallCheck
@onready var killzone: Area2D = $killzoneSlime
@onready var explosion_sound: AudioStreamPlayer2D = $ExplosionSound

var direction = -1
var health = 1
var is_dead = false
var is_attacking = false


func _ready() -> void:
	sprite.play("Idle")


func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if is_attacking:
		velocity.x = 0
		move_and_slide()
		return

	if not floor_check.is_colliding() or wall_check.is_colliding():
		turn_around()

	velocity.x = direction * SPEED
	move_and_slide()

	sprite.flip_h = direction < 0
	sprite.play("Walking")


func turn_around() -> void:
	direction *= -1

	floor_check.position.x = abs(floor_check.position.x) * direction
	wall_check.position.x = abs(wall_check.position.x) * direction
	wall_check.target_position.x = 12 * direction


func take_damage(amount: int) -> void:
	if is_dead:
		return

	health -= amount
	print("Slime took damage. Health now: ", health)

	if health <= 0:
		die()
	else:
		sprite.play("Hit")


func die() -> void:
	if is_dead:
		return

	is_dead = true
	velocity = Vector2.ZERO

	if killzone:
		killzone.monitoring = false

	explosion_sound.play()
	sprite.play("Die")

	await get_tree().create_timer(0.5).timeout

	queue_free()


func attack_player(player: Node2D) -> void:
	if is_dead or is_attacking:
		return

	is_attacking = true
	velocity.x = 0
	sprite.play("Attack")

	await sprite.animation_finished

	if player != null and player.has_method("die"):
		player.die()

	is_attacking = false
