extends Sprite2D

@onready var label: RichTextLabel = $VBoxContainer/RichTextLabel
@onready var text_player: PitchedAudioStreamPlayer = $TextPlayer

var preamble : String = "[center][wave amp=10.0 freq=5.0 connected=1]"
var already_active = false

func show_text(text : String):
	if not already_active:
		already_active = true
		self.modulate = Color(1, 1, 1, 1)
		var label_text = ""
		label.text = preamble
		var words : Array = text.split(" ")
		label.text += words[0]
		words.pop_at(0)
		text_player._play()
		await get_tree().create_timer(0.3).timeout
		for word in words:
			label.text += " " + word
			text_player._play()
			await get_tree().create_timer(0.3).timeout
		await get_tree().create_timer(1).timeout
		await fade_out()

func fade_out():
	var tweener : Tween = get_tree().create_tween()
	await tweener.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.5).finished
	already_active = false

func _ready() -> void:
	self.modulate = Color(1, 1, 1, 0)
