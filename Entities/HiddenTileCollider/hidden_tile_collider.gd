class_name  HiddenTileCollider
extends Area2D

@export var player: Player

var nearest: Node2D

var tween: Tween

func _on_body_entered(_body: Node2D) -> void:
	var nearest_dist = 10000000
	for i in player.lights.get_child_count():
		var light: Light2D = player.lights.get_child(i)
		var light_dist: float = player.global_position.distance_to(light.global_position)
		if light_dist <= nearest_dist:
			nearest = light
			nearest_dist = light_dist
	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		nearest, "scale:x", 0, 0.2)

func _on_body_exited(_body: Node2D) -> void:
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
		
	tween.tween_property(
		nearest, "scale:x", 1, 0.2)
