extends Hermit

@onready var interaction_zone: Area2D = $InteractionZone
@onready var collision_shape_2d: CollisionShape2D = $InteractionZone/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialogue := [
	"Welcome Traveller...",
	"There are 12 endings hidden in these lands",
	"If you need a hint, you can talk to me anytime",
	"You just need to find me...",
	"Oh, and if you want to see the endings menu, press [Tab]"
]

func _ready() -> void:
	if EndingStorageGlobal.get_num_of_endings() < 1 or EndingStorageGlobal.temp_hermit_talked_to == true:
		queue_free()
	talk_count = 0
	

func speak():
	EndingStorageGlobal.temp_hermit_talked_to = true
	interaction_zone.set_deferred("monitoring", false)
	while true:
		if talk_count < dialogue.size():
			await show_text(dialogue[talk_count])
			await  get_tree().create_timer(0.2).timeout
			talk_count += 1
		else:
			animation_player.play("FADE_OUT")
			await animation_player.animation_finished
			self.queue_free()

func show_text(text : String):
	await speech_bubble.show_text(text)
