extends Node

@onready var start_area = load("res://Stages/StartArea/start_area.tscn")
@onready var ending_storage_ui = load("res://Assets/Globals/ending_storage/ending_storage_ui.tscn")

func _ready() -> void:
	CameraTransition.zoom_finished.connect(_on_zoom_finished)

func _on_zoom_finished() -> void:
	get_tree().change_scene_to_packed(ending_storage_ui)

func _on_ui_finished() -> void:
	get_tree().change_scene_to_packed(start_area)
