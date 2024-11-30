extends ExitFlagZone

func _perform_action(player: Player) -> void:
	player.menu_openable = false
	EndingStorageUiGlobal.canvas_modulate.color = Color(1,1,1,0)
	active = false
	
	var height = player.global_position.y - 6
	height = clamp(height, global_position.y-80, global_position.y-22)
	
	player.set_process(false)
	
	flag.global_position.y = height
	
	if flag.global_position.x < player.global_position.x:
		player.player_sprite.flip_h = true
		flag.flip_h = true
	else:
		player.player_sprite.flip_h = false
	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		flag, "modulate", Color(1,1,1,1), 0.5)
	tween.parallel().tween_property(
		player, "global_position:y", height+6, 0.5)
	tween.tween_property(
		flag, "global_position:y", global_position.y-22, (global_position.y-16 - height)/50)
	tween.parallel().tween_property(
		player, "global_position:y", global_position.y-16, (global_position.y-16 - height)/50)
	
	await(tween.finished)
	
	#EndingStorageGlobal.endings[ending.storage_pos] = ending
	#CameraTransition.camera_end_zoom()
