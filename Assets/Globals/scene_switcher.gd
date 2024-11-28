extends Node

@onready var start_area_scene = load("res://Stages/StartArea/start_area.tscn")
@onready var ending_storage_ui_scene = load("res://Assets/Globals/ending_storage/ending_storage_ui.tscn")

var ending_storage_ui: EndingStorageUI

const FADE_TIME: float = 1.0
const ENDING_UI_TIME: float = 4.0
var timer : Timer = Timer.new()

func _ready() -> void:
	CameraTransition.zoom_finished.connect(_on_zoom_finished)
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _on_zoom_finished() -> void:
	EndingStorageUiGlobal.fade_in(FADE_TIME)
	
	await(EndingStorageUiGlobal.done)
	
	get_tree().reload_current_scene()
	get_tree().paused = false
	
	timer.start(ENDING_UI_TIME)

func on_ui_finished() -> void:
	MusicPlayer.switch_music("Normal")
	EndingStorageUiGlobal.fade_out(FADE_TIME)

func _on_timer_timeout():
	SceneSwitcher.on_ui_finished()
