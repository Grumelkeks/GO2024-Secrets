class_name Spike
extends InteractionZone

@export var ending: Ending

func _perform_action(_player: Player) -> void:
	EndingStorageGlobal.endings[ending.storage_pos] = ending
	CameraTransition.camera_end_zoom()
