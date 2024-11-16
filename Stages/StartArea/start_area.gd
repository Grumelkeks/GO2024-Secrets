extends Node2D

@onready var start_camera: Camera2D = $StartCamera

func _ready() -> void:
	start_camera.make_current()
