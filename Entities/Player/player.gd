class_name Player
extends CharacterBody2D

@export var ending: Ending

@export var lights: Node

@export var stats : PlayerStats

@export var torch: PointLight2D

var direction : float
var facing_dir : float = 1

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var animation_player: AnimationPlayer = $PlayerSprite/AnimationPlayer

var push_force = 20.0

@onready var audio_listener_2d: AudioListener2D = $AudioListener2D

var platform: StaticBody2D
var platform_old_pos: float = 0

var menu_openable: bool = true

var coins = 0

func _ready() -> void:
	audio_listener_2d.make_current()

func _process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_movement(delta)
	_handle_animations()
	
	move_and_slide()
	
	if not is_on_floor():
		platform = null
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var collider = c.get_collider()
		if collider is Pushable:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
		if collider.name == "Platform":
			if platform != collider:
				platform = collider
				platform_old_pos = platform.global_position.x
				platform.get_parent().bounce()
			else:
				global_position.x += platform.global_position.x - platform_old_pos
				platform_old_pos = platform.global_position.x
	
	if coins >= 6:
		EndingStorageGlobal.endings[ending.storage_pos] = ending
		CameraTransition.camera_end_zoom()

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
	
	if is_on_floor():
		if velocity.x:
			animation_player.play("WALK")
		else:
			animation_player.play("IDLE")
		
		if direction * sign(velocity.x) == -1:
			animation_player.play("TURN")
	else:
		if velocity.y < 0:
			animation_player.play("JUMP")
		else:
			animation_player.play("FALL")
			
	if torch:
		torch.position.x = facing_dir * 7
	player_sprite.flip_h = facing_dir < 0

func try_jump() -> void:
	if is_on_floor():
		_jump()

func _jump() -> void:
	velocity.y =  -(stats.BASE_JUMP_SPEED + stats.JUMP_SPEED_INCR * int(abs(velocity.x) / 30))

func menu() -> void:
	if menu_openable:
		if EndingStorageUiGlobal.canvas_modulate.color == Color(1,1,1,0):
			set_process(false)
			MusicPlayer.switch_music("Endings")
			EndingStorageUiGlobal.canvas_modulate.color = Color(1,1,1,1)
		else:
			MusicPlayer.switch_music("Normal")
			EndingStorageUiGlobal.canvas_modulate.color = Color(1,1,1,0)
			set_process(true)

func set_input(boolean : bool):
	$PlayerInput.set_process(boolean)
