class_name EndingStorage
extends Node

@export var lit_torches: Array[StringName]
@export var endings: Array[Ending]

@export var torches_ending: Ending = preload("res://Assets/Globals/ending_storage/Endings/CaveTorches/cave_torches.tres")
var once = true

var campfire_lit = false

var count_end = 4
var rows_done: Array[bool] = [false, false, false]
@onready var all_player: PitchedAudioStreamPlayer = $AllPlayer

@export var coins_ending: Ending = preload("res://Assets/Globals/ending_storage/Endings/AirCoins/air_coins.tres")
@onready var coins: Array[StringName]

var big_rock_pos:Vector2 = Vector2(312, 240)
var temp_hermit_talked_to = false
var hermit_talked_to = false

func coin_pickup(coin: Coin) -> void:
	coins.append(coin.name)
	if coins.size() >= 6:
		EndingStorageGlobal.endings[coins_ending.storage_pos] = coins_ending
		CameraTransition.camera_end_zoom()

func torch_light_up(torch: WallTorch):
	lit_torches.append(torch.name)
	if lit_torches.size() >= 7:
		EndingStorageGlobal.endings[torches_ending.storage_pos] = torches_ending
		CameraTransition.camera_end_zoom()

func full_row():
	for i in range(3):
		_check_all(i*4)

func _check_all(row: int):
	var count = 0
	
	for i in range(4):
		if endings[i+row] != null:
			count += 1
	
	if count >= 4 and not rows_done[row/4]:
		rows_done[row/4] = true
		for i in range(4):
			EndingStorageUiGlobal.slots[i+row].animation_player.play(GlobalNames.animations.scale)
		all_player.play()
	
	if count >= count_end:
		count_end += 4

func get_num_of_endings() -> int:
	var count = 0
	for i in endings.size():
		if endings[i] != null:
			count += 1
	
	return count
