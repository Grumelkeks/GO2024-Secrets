extends CanvasLayer

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var timer : Timer = Timer.new()

func _ready() -> void:
	update_slots()
	add_child(timer)
	timer.start(5)
	timer.timeout.connect(_on_time_out)

func update_slots():
	for i in range(min(EndingStorageGlobal.endings.size(), slots.size())):
		slots[i].update(EndingStorageGlobal.endings[i])

func _on_time_out():
	get_tree().change_scene_to_packed(load("res://Stages/StartArea/start_area.tscn"))
