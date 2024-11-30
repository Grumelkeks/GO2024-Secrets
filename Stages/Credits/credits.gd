class_name Credits
extends CanvasLayer

@onready var ending: Label = $VBoxContainer/Ending
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_flag_ending():
	ending.text = "--- The Flag Ending ---"
	self.visible = true
	animation_player.play("FadeIn")

func set_door_ending():
	ending.text = "--- Secret Door Ending ---"
	self.visible = true
	animation_player.play("FadeIn")
