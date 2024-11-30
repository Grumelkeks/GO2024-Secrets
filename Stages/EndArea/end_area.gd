extends Node2D

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

func ghost_appear():
	player.direction = 0
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
		fading_layer, "modulate", Color(1,1,1,1), HIDDEN_LAYER_FADE_TIME)
	
	await(tween.finished)
	
	fading_layer.collision_enabled = true
