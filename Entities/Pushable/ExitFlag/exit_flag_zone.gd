class_name ExitFlagZone
extends InteractionZone

@export var ending: Ending
@export var flag: Sprite2D

var tween : Tween

func _perform_action(player: Player) -> void:
	active = false
	
	var height = player.global_position.y
	height = clamp(height, global_position.y-80, global_position.y-16)
	
	flag.global_position.y = height
	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		flag, "modulate", Color(1,1,1,1), 0.5)
	tween.tween_property(
		flag, "global_position:y", global_position.y-24, (global_position.y-16 - height)/50)
	
	await(tween.finished)
	
	EndingStorageGlobal.endings[ending.storage_pos] = ending
	CameraTransition.camera_end_zoom()
