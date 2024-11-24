class_name TorchPickup
extends InteractionZone

var torch : PointLight2D = preload("res://Entities/Torches/Torch/torch.tscn").instantiate()

func _perform_action(player: Player) -> void:
	active = false
	torch.position = Vector2(-7, -8)
	player.add_child(torch)
	player.torch = torch
