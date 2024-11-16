class_name  HiddenTileCollider
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	body.modulate = Color(1, 1, 1, 0.2)

func _on_body_exited(body: Node2D) -> void:
	body.modulate = Color(1, 1, 1, 1)
