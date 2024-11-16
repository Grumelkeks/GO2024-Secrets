extends Node

signal finished_transition()

@onready var camera: Camera2D = $Camera2D

var transitioning = false

var tween : Tween

func transition_camera(from: Camera2D, to: Camera2D, duration: float) -> void:
	if transitioning or not from.is_current():
		return
	transitioning = true
	camera.make_current()
	
	camera.zoom = from.zoom
	camera.offset = from.offset
	camera.global_transform = from.global_transform

	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT).set_parallel(true)
	
	tween.tween_property(
		camera, "global_transform", to.global_transform, duration)
	tween.tween_property(
		camera, "zoom", to.zoom, duration)
	tween.tween_property(
		camera, "offset", to.offset, duration)
	
	await(tween.finished)
	
	to.make_current()
	transitioning = false
	emit_signal("finished_transition")
