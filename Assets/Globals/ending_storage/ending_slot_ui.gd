extends Panel

@export var ending_color: Texture2D

@onready var ending_display: Sprite2D = $CenterContainer/EndingDisplay
@onready var slot: Sprite2D = $Slot


func update(ending: Ending) -> void:
	slot.texture = ending_color
	if !ending:
		ending_display.visible = false
	else:
		ending_display.visible = true
		ending_display.texture = ending.texture
	
