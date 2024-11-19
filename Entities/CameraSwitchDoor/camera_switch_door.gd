extends Node2D

@export var from : Camera2D
@export var to : Camera2D
@export_range(0, 2, 0.1, "or_greater") var duration : float = 1.0

@onready var camera_switch_out: CameraSwitch = $CameraSwitchOut
@onready var camera_switch_in: CameraSwitch = $CameraSwitchIn

func _ready() -> void:
	camera_switch_out.from = from
	camera_switch_out.to = to
	camera_switch_out.duration = duration
	
	camera_switch_in.from = to
	camera_switch_in.to = from
	camera_switch_in.duration = duration
