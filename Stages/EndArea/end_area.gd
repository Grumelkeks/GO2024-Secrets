extends Node2D

@onready var camera: Camera2D = $Camera
@onready var hermit_ghost: AnimatedSprite2D = $HermitGhost
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Player
@onready var whoosh_player: PitchedAudioStreamPlayer = $HermitGhost/WhooshPlayer

func _ready() -> void:
	camera.make_current()
	MusicPlayer.switch_music("Ending")
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
