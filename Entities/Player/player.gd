class_name Player
extends CharacterBody2D

@export var lights: Node

@export var stats : PlayerStats

@export var torch: PointLight2D

var direction : float
var facing_dir : float = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var push_force = 20.0

func _process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_movement(delta)
	_handle_animations()
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func _apply_gravity(delta : float) -> void:
	if not is_on_floor() and Input.is_action_pressed(GlobalNames.actions.jump):
		velocity.y += stats.EXTRA_GRAVITY * delta
	elif not is_on_floor():
		velocity.y += stats.STANDARD_GRAVITY * delta

func _handle_movement(delta : float) -> void:
	if direction:
		facing_dir = direction
		velocity.x = move_toward(velocity.x, direction * stats.MAX_SPEED, stats.WALK_ACCEL * delta)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, stats.STOP_DECEL * delta)

func _handle_animations() -> void:
	if velocity.x:
		animated_sprite.play(GlobalNames.animations.walk)
	else:
		animated_sprite.play(GlobalNames.animations.idle)
	
	if direction * sign(velocity.x) == -1:
		animated_sprite.play(GlobalNames.animations.turn)
	
	if torch:
		torch.position.x = facing_dir * 7
	animated_sprite.flip_h = facing_dir < 0
	
	if not is_on_floor():
		if velocity.y > 0:
			animated_sprite.play(GlobalNames.animations.fall)
		else:
			animated_sprite.play(GlobalNames.animations.jump)

func try_jump() -> void:
	if is_on_floor():
		_jump()

func _jump() -> void:
	velocity.y =  -(stats.BASE_JUMP_SPEED + stats.JUMP_SPEED_INCR * int(abs(velocity.x) / 30))
