class_name EndingStorage
extends Node

@export var lit_torches: Array[StringName]
@export var endings: Array[Ending]

@export var torches_ending: Ending = preload("res://Assets/Globals/ending_storage/Endings/CaveTorches/cave_torches.tres")
var once = true

func _process(_delta: float) -> void:
	if lit_torches.size() >= 7:
		set_process(false)
		
		EndingStorageGlobal.endings[torches_ending.storage_pos] = torches_ending
		CameraTransition.camera_end_zoom()
