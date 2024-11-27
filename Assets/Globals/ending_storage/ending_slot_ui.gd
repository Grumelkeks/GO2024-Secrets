extends Panel

@export var ending_color: Texture2D

@onready var ending_display: Sprite2D = $CenterContainer/EndingDisplay
@onready var slot: Sprite2D = $Slot

var unlocked = false


#func update(ending: Ending) -> void:
	#slot.texture = ending_color
	#if !ending:
		#ending_display.modulate = Color(1,1,1,0)
	#else:
		#ending_display.texture = ending.texture
		#
		#if tween:
			#tween.kill()
		#
		#tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	#
		#tween.tween_property(
			#ending_display, "modulate", Color(1,1,1,1), TWEEN_TIME)

func update(ending: Ending) -> void:
	slot.texture = ending_color
	if !ending:
		ending_display.modulate = Color(1,1,1,0)
	else:
		if not unlocked:
			ending_display.texture = ending.texture
			$CenterContainer/Unlock/AnimationPlayer.play("UNLOCK")
			unlocked = true
		ending_display.modulate = Color(1,1,1,1)
