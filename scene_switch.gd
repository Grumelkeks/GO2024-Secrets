class_name CameraSwitch
extends Area2D

@export var from : Camera2D
@export var to : Camera2D
@export_range(0, 2, 0.1, "or_greater") var duration : float = 1.0

func _on_body_entered(_body: Node2D) -> void:
	if(CameraTransition.transitioning == true):
		await(CameraTransition.finished_transition)
	CameraTransition.transition_camera(from, to, duration)
