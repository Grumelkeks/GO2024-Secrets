extends Node2D

@onready var start_camera: Camera2D = $Cameras/StartCamera

@onready var music: AudioStream = preload("res://Assets/Audio/Music/NormalTheme.ogg")

func _ready() -> void:
	start_camera.make_current()
