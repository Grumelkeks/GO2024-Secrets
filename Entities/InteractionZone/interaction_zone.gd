class_name InteractionZone
extends Area2D

var player : Player

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not player:
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player" and player:
		player = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(GlobalNames.actions.interact) and player:
		_perform_action()

func _perform_action() -> void:
	pass
