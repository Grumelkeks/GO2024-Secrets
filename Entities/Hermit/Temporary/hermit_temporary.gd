extends Hermit

@onready var interaction_zone: Area2D = $InteractionZone
@onready var collision_shape_2d: CollisionShape2D = $InteractionZone/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialogue := [
	"Welcome Traveller ...",
	"I see you found one ending to this story already...",
	"Find all 12 to be rewarded...",
	"If you need a hint, you can talk to me anytime",
	"You just need to find me...",
	"Just remember ...",
	"Not everything is as it seems"
]

func _ready() -> void:
	if EndingStorageGlobal.get_num_of_endings() != 1:
		queue_free()
	talk_count = 0

func speak():
	interaction_zone.set_deferred("monitoring", false)
	while true:
		if talk_count < dialogue.size():
			await  get_tree().create_timer(0.4).timeout
			await show_text(dialogue[talk_count])
			talk_count += 1
		else:
			animation_player.play("FADE_OUT")
			await animation_player.animation_finished
			self.queue_free()

func show_text(text : String):
	print(text)
	await speech_bubble.show_text(text)
