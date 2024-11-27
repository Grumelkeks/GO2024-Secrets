class_name EndingStorageUI
extends CanvasLayer

signal done

@onready var slots: Array = $GridContainer.get_children()
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var tween: Tween

func _ready() -> void:
	update_slots()

func update_slots():
	for i in range(min(EndingStorageGlobal.endings.size(), slots.size())):
		slots[i].update(EndingStorageGlobal.endings[i])

func fade_in(time: float) -> void:
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(
		canvas_modulate, "color", Color(1,1,1,1), time)
	
	await(tween.finished)
	
	EndingStorageUiGlobal.update_slots()
	done.emit()

func fade_out(time: float) -> void:
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween().bind_node(self).set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		canvas_modulate, "color", Color(1,1,1,0), time)
	
	await(tween.finished)
	
	done.emit()
