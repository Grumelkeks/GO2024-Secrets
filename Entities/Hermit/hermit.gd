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
	"castle" : "That flag pole look oddly pushable...",
	"death" : "The sharpest path may lead to freedom...",
	"grassDoor" : "I'm sure you can get to the door up there...",
	# Cave
	"torches" : "The light will guide you to an end...",
	"roast" : "Don't stand by the fire for too long!",
	"caveDoor" : "Squeeze through a gap in the cave to find a door...",
	# Air
	"castleTop" : "Ascend to the sky, then take the plunge...",
	"coins" : "Everything can be bought... even an ending",
	"airDoor" : "I heard there's a door hidden somewhere in the clouds...",
	# Extras
	"caveLocked" : "Have you found a way into the underground yet?",
	"skyLocked" : "Have you tried lighting the campfire?",
	"skyNotFound" : "Ascend with the clouds"
}

var secret_text = [
	"I'm just a hermit why are you questioning me?",
	"It's been so long since I've talked to someone...",
	"I still remember the time when I travelled these lands",
	"Need any more hints?",
	"By the way, if you want to see the endings menu, press [Tab]"
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
		if EndingStorageGlobal.campfire_lit == false:
			active_endings.append("skyLocked")
		else:
			active_endings.append("skyNotFound")
	
	active_endings.shuffle()

func speak():
	if talk_count == 0 and EndingStorageGlobal.temp_hermit_talked_to == true and EndingStorageGlobal.hermit_talked_to == false:
		show_text("So you found me... Do you need a hint?")
	elif talk_count == 0 and EndingStorageGlobal.hermit_talked_to == false:
		show_text("Welcome traveller... Do you need a hint?")
	elif (talk_count + 1) % 4 == 0:
		show_text(secret_text.pick_random())
	else:
		show_text(text_dict[active_endings[endings_position % active_endings.size()]])
		endings_position += 1
	talk_count += 1
	EndingStorageGlobal.hermit_talked_to = true

func show_text(text : String):
	speech_bubble.show_text(text)
