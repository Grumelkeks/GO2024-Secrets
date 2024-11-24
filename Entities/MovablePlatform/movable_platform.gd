class_name MovablePlatform
extends PathFollow2D

@export var duration: float = 10.0

var tween: Tween

func _ready() -> void:
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
	
	tween.tween_property(
		self, "progress_ratio", 1, duration)
	tween.tween_property(
		self, "modulate", Color(1,1,1,0), duration)
	
	await(tween.finished)
	
	queue_free()
	
