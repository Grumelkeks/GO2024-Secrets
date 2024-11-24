class_name InteractionZone
extends Area2D

var active = true

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and active:
		_perform_action(body)

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_perform_action_deactivate(body)

func _perform_action(_player: Player) -> void:
	pass

func _perform_action_deactivate(_player: Player) -> void:
	pass
