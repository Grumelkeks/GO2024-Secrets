class_name Campfire
extends InteractionZone

@export var ending: Ending
@export var roast_time: float = 4.0

@onready var roast_timer: Timer = $RoastTimer

@export var pushable: Pushable
@export var path_2d: Path2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var torch_particles: CPUParticles2D = $TorchParticles

@onready var timer: Timer = $Timer
const platform_spawn_time: float = 3.3
const rand_range = 1
var rand_gen = RandomNumberGenerator.new()

@onready var movable_platform := preload("res://Entities/MovablePlatform/movable_platform.tscn")

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var lightable = true

func _ready() -> void:
	super()
	roast_timer.timeout.connect(_on_roast_timer_timeout)
	timer.timeout.connect(_on_timer_timeout)
	if EndingStorageGlobal.campfire_lit:
		lightable = false
		call_deferred("_action")

func _perform_action(player: Player):
	if not lightable:
		roast_timer.start(roast_time)
	if player.torch != null and lightable:
		lightable = false
		roast_timer.start(roast_time)
		_action()
		EndingStorageGlobal.campfire_lit = true

func _perform_action_deactivate(_player: Player):
	if not lightable:
		roast_timer.stop()

func _action():
	audio_stream_player_2d.play()
	animated_sprite_2d.play("light_up")
	torch_particles.emitting = true
	
	await(animated_sprite_2d.animation_finished)
	
	animated_sprite_2d.play("lit")
	var movable_platform_instance = movable_platform.instantiate()
	movable_platform_instance.campfire = true
	path_2d.add_child(movable_platform_instance)
	timer.start(platform_spawn_time)

func _on_timer_timeout() -> void:
	var movable_platform_instance = movable_platform.instantiate()
	movable_platform_instance.campfire = true
	path_2d.add_child(movable_platform_instance)
	
	var rand = rand_gen.randf_range(-rand_range, rand_range)
	timer.start(platform_spawn_time + rand)

func _process(_delta: float) -> void:
	global_position.x = pushable.global_position.x

func _on_roast_timer_timeout() -> void:
	EndingStorageGlobal.endings[ending.storage_pos] = ending
	CameraTransition.camera_end_zoom()
