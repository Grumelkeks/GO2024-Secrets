class_name CastleRoof
extends InteractionZone

@export var ending = preload("res://Assets/Globals/ending_storage/Endings/AirCastle/air_castle.tres")

func _perform_action(_player: Player) -> void:
	EndingStorageGlobal.endings[ending.storage_pos] = ending
	CameraTransition.camera_end_zoom()
