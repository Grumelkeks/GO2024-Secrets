extends Hermit

var dialogue := [
	"So you did it, my boy...",
	"You found every ending",
	"You can be proud of yourself",
	"... What's the reward, you're asking?",
	"The experience, that's the reward",
	"Now go, go and find yourself...",
]

func _ready() -> void:
	talk_count = 0

func speak():
	while true:
		if talk_count < dialogue.size():
			await  get_tree().create_timer(0.4).timeout
			await show_text(dialogue[talk_count])
			talk_count += 1
		else:
			break

func show_text(text : String):
	await speech_bubble.show_text(text)
