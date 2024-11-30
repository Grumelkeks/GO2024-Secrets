class_name ExitDoor
extends InteractionZone

@export var ending: Ending

func _perform_action(_player: Player):
	if ending == null:
		push_warning("Ending null! May be unintentional")
		CameraTransition.end_area_camera_zoom(true)
	else:
		EndingStorageGlobal.endings[ending.storage_pos] = ending
		CameraTransition.camera_end_zoom()
