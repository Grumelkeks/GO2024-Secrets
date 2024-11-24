class_name TorchLightRemover
extends InteractionZone

var down = false

func _ready() -> void:
	super()
	if global_rotation != 0:
		down = true

func _perform_action(player: Player) -> void:
	if player.torch != null:
		if not down:
			player.torch.enabled = false
			return
		
		player.torch.enabled = true
