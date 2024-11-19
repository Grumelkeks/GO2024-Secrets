class_name CameraSwitch
extends Area2D

var from : Camera2D
var to : Camera2D
var duration : float = 1.0

func _on_body_entered(_body: Node2D) -> void:
	if(CameraTransition.transitioning == true):
		await(CameraTransition.finished_transition)
	CameraTransition.transition_camera(from, to, duration)
