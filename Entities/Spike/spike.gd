class_name Spike
extends Area2D

@export var ending: Ending = preload("res://Assets/Globals/ending_storage/TempEnding/temp_ending.tres")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		EndingStorageGlobal.endings[2] = ending
		get_tree().call_deferred("change_scene_to_packed", load("res://Assets/Globals/ending_storage/ending_storage_ui.tscn"))
