class_name ExitDoor
extends InteractionZone

@export var ending: Ending

func _perform_action():
	EndingStorageGlobal.endings[1] = ending
	get_tree().change_scene_to_packed(load("res://Assets/Globals/ending_storage/ending_storage_ui.tscn"))
