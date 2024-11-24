class_name Campfire
extends InteractionZone

@export var pushable: Pushable
@export var path_2d: Path2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var torch_particles: CPUParticles2D = $TorchParticles

@onready var timer: Timer = $Timer
const platform_spawn_time: float = 3.3
const rand_range = 1
var rand_gen = RandomNumberGenerator.new()

@onready var movable_platform := preload("res://Entities/MovablePlatform/movable_platform.tscn")

func _ready() -> void:
	super()
	timer.timeout.connect(_on_timer_timeout)

func _perform_action(player: Player):
	if player.torch != null:
		active = false
		_action()

func _action():
	animated_sprite_2d.play("light_up")
	torch_particles.emitting = true
	
	await(animated_sprite_2d.animation_finished)
	
	animated_sprite_2d.play("lit")
	var movable_platform_instance = movable_platform.instantiate()
	path_2d.add_child(movable_platform_instance)
	timer.start(platform_spawn_time)

func _on_timer_timeout() -> void:
	var movable_platform_instance = movable_platform.instantiate()
	path_2d.add_child(movable_platform_instance)
	
	var rand = rand_gen.randf_range(-rand_range, rand_range)
	timer.start(platform_spawn_time + rand)

func _process(_delta: float) -> void:
	global_position.x = pushable.global_position.x
