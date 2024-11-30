extends "res://Entities/InteractionZone/interaction_zone.gd"

func _perform_action(_player: Player) -> void:
	get_parent().ghost_appear()
	self.queue_free()

func _perform_action_deactivate(_player: Player) -> void:
	pass
