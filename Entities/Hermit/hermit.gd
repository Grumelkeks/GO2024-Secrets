extends AnimatedSprite2D
class_name Hermit

@onready var speech_bubble: Sprite2D = $SpeechBubble

var endings := [
	"flags", "castle", "grassDoor", "death",
	"flags", "torches", "caveDoor", "roast",
	"flags", "coins", "airDoor", "castleTop"
]

var active_endings : Array = []

var text_dict := {
	# General
	"general" : "Press [Tab] to show the endings menu",
	"flags" : "There's a flag to climb in all 3 areas...",
	# Normal
	"castle" : "Is there really no way to get into the castle...",
	"death" : "The sharpest path may lead to freedom...",
	"grassDoor" : "I'm sure you can get to the door up there...",
	# Cave
	"torches" : "The light will guide you to an end...",
	"roast" : "Cold. Warm. Warmer. Scorching. Burning...",
	"caveDoor" : "Squeeze through a gap in the cave to find a door...",
	# Air
	"castleTop" : "Ascend to the sky, then take the plunge...",
	"coins" : "Collecting the stars might lead you somewhere...",
	"airDoor" : "I heard there's a door hidden somewhere in the clouds...",
	# Extras
	"caveLocked" : "Have you found a way into the underground yet?",
	"skyLocked" : "Have you tried lighting the campfire?",
}

var secret_text = [
	"I'm just a hermit why are you questioning me?",
	"It's been so long since I've talked to someone...",
	"Need any more hints?"
]

var talk_count = 0
var endings_position = 0

var endings_mask := [
	0, 0, 0, 0,
	0, 0, 0, 0,
	0, 0, 0, 0,
]
func _ready():
	load_endings()

func load_endings():
	for idx in EndingStorageGlobal.endings.size():
		if EndingStorageGlobal.endings[idx] != null:
			endings_mask[idx] = 1
	var cave_unlocked = endings_mask.slice(4, 8).max() >= 1
	var sky_unlocked = endings_mask.slice(8, 12).max() >= 1
	# Just first Endings
	for idx in range(0, 4):
		if endings_mask[idx] == 0:
			active_endings.append(endings[idx])
	# Cave Endings
	if cave_unlocked:
		for idx in range(4, 8):
			if endings_mask[idx] == 0:
				active_endings.append(endings[idx])
	else:
		active_endings.append("caveLocked")
	# Sky Endings
	if sky_unlocked:
		for idx in range(8, 12):
			if endings_mask[idx] == 0:
				active_endings.append(endings[idx])
	elif endings_mask[5] == 1:
		active_endings.append("skyLocked")
	
	active_endings.shuffle()

func speak():
	if talk_count == 0:
		show_text(text_dict["general"])
	elif talk_count % 4 == 0:
		show_text(secret_text.pick_random())
	else:
		show_text(text_dict[active_endings[endings_position % active_endings.size()]])
		endings_position += 1
	talk_count += 1

func show_text(text : String):
	speech_bubble.show_text(text)
