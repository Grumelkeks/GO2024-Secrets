extends Node2D

@onready var credits: Credits = $Credits
@onready var clouds: Node = $Clouds

@onready var camera: Camera2D = $Cameras/Camera

@onready var hermit_ghost: AnimatedSprite2D = $HermitGhost
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Player
@onready var whoosh_player: PitchedAudioStreamPlayer = $HermitGhost/WhooshPlayer

@onready var fading_layer: TileMapLayer = $FadingLayer
const HIDDEN_LAYER_FADE_TIME: float = 1.0

var tween: Tween

func _ready() -> void:
	fading_layer.modulate = Color(1,1,1,0)
	fading_layer.collision_enabled = false
	camera.make_current()
	player.menu_openable = false
	CameraTransition.end_area_zoom_finished.connect(_on_end_zoom_finished)
	clouds.process_mode = Node.PROCESS_MODE_DISABLED
	clouds.modulate = Color(1,1,1,0)
	MusicPlayer.switch_music("Ending")

func ghost_appear():
	player.direction = 0
	player.velocity.x /= 2
	player.set_input(false)
	animation_player.play("GhostAppear")
	whoosh_player._play()
	await animation_player.animation_finished
	await hermit_ghost.speak()
	animation_player.play("GhostAppear", -1, -1, true)
	whoosh_player._play()
	await animation_player.animation_finished
	player.set_input(true)
	
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		clouds, "modulate", Color(1,1,1,1), HIDDEN_LAYER_FADE_TIME)
	
	await(tween.finished)
	
	clouds.process_mode = Node.PROCESS_MODE_INHERIT

func _on_end_zoom_finished(door: bool) -> void:
	if door:
		credits.set_door_ending()
	else:
		credits.set_flag_ending()
