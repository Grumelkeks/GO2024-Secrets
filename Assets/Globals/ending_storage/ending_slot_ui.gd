extends Panel

@onready var ending_display: Sprite2D = $CenterContainer/ending_display

func update(ending: Ending) -> void:
	if !ending:
		ending_display.visible = false
	else:
		ending_display.visible = true
		ending_display.texture = ending.texture
	
