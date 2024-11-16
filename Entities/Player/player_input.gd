class_name PlayerInput
extends Node

@export var player : Player

func _process(_delta: float) -> void:
	player.direction = Input.get_axis(GlobalNames.actions.left, GlobalNames.actions.right)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(GlobalNames.actions.jump):
		player.try_jump()
