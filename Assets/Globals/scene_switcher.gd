extends Node

const END_AREA = preload("res://Stages/EndArea/end_area.tscn")

var ending_storage_ui: EndingStorageUI
const FADE_TIME: float = 1.0
const ENDING_UI_TIME: float = 4.0
var timer : Timer = Timer.new()

var music: StringName = "Normal"

func _ready() -> void:
	CameraTransition.zoom_finished.connect(_on_zoom_finished)
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _on_zoom_finished() -> void:
	EndingStorageUiGlobal.fade_in(FADE_TIME)
	
	await(EndingStorageUiGlobal.done)

	AudioServer.set_bus_effect_enabled(2,0, false)
	if EndingStorageGlobal.get_num_of_endings() >= 12:
		get_tree().change_scene_to_packed(END_AREA)
		music = "Ending"
		get_tree().paused = false
		timer.start(ENDING_UI_TIME)
		return
	get_tree().reload_current_scene()
	get_tree().paused = false
	
	timer.start(ENDING_UI_TIME)

func on_ui_finished() -> void:
	MusicPlayer.switch_music(music)
	EndingStorageUiGlobal.fade_out(FADE_TIME)

func _on_timer_timeout():
	SceneSwitcher.on_ui_finished()
