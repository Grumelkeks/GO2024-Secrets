extends "res://Entities/InteractionZone/interaction_zone.gd"

func _perform_action(_player: Player) -> void:
	get_parent().speak()

func _perform_action_deactivate(_player: Player) -> void:
	pass
