extends Panel

@export var ending_color: Texture2D

@onready var ending_display: Sprite2D = $CenterContainer/EndingDisplay
@onready var animation_player: AnimationPlayer = $CenterContainer/Unlock/AnimationPlayer


@onready var slot: Sprite2D = $Slot

var unlocked = false

func update(ending: Ending) -> void:
	slot.texture = ending_color
	if !ending:
		ending_display.modulate = Color(1,1,1,0)
	else:
		if not unlocked:
			ending_display.texture = ending.texture
			animation_player.play(GlobalNames.animations.unlock)
			unlocked = true
		ending_display.modulate = Color(1,1,1,1)

func try_all_rows():
	EndingStorageGlobal.full_row()
