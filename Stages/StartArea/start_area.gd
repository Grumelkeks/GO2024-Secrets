extends Node2D

@onready var start_camera: Camera2D = $Cameras/StartCamera

@onready var music: AudioStream = preload("res://Assets/Audio/Music/NormalTheme.ogg")

func _ready() -> void:
	MusicPlayer.switch_music("Normal")
	start_camera.make_current()
