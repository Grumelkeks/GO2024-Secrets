class_name ExitFlagZone
extends Area2D

signal finished()

@export var ending: Ending

@onready var flag: Sprite2D = $"../Flag"

var tween : Tween
var active = true

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body : Node2D) -> void:
	if body.name == "Player" and active:
		active = false
		_perform_action(body)

func _perform_action(player : Player) -> void:
	var height = player.global_position.y
	height = clamp(height, 154, 219)
	
	flag.global_position.y = height
	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT)
	
	tween.tween_property(
		flag, "modulate", Color(1,1,1,1), 0.5)
	tween.tween_property(
		flag, "global_position:y", 219, (219 - height)/50)
	
	await(tween.finished)
	
	EndingStorageGlobal.endings[0] = ending
	get_tree().change_scene_to_packed(load("res://Assets/Globals/ending_storage/ending_storage_ui.tscn"))
