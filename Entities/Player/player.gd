class_name Player
extends CharacterBody2D

@export var stats : PlayerStats

var direction : float
var facing_dir : float = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_movement(delta)
	_handle_animations()

	move_and_slide()

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
