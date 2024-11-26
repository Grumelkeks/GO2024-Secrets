class_name ActivateArrow
extends InteractionZone

func _perform_action(_player: Player) -> void:
	get_parent().get_node("LightArrowPath").get_node("LightArrow").activate()
