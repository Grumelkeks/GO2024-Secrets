class_name TorchLightRemover
extends InteractionZone

var down = false

func _ready() -> void:
	super()
	if global_rotation != 0:
		down = true

func _perform_action(player: Player) -> void:
	if not down:
		AudioServer.set_bus_effect_enabled(2,0, false)
		if player.torch != null:
			player.torch.enabled = false
	else:
		AudioServer.set_bus_effect_enabled(2,0, true)
		if player.torch != null:
			player.torch.enabled = true
