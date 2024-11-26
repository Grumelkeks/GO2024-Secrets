@tool
class_name OneWayCloud
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var small: bool = false:
	set(value):
		small = value
		if Engine.is_editor_hint():
			call_deferred("_small_set")

func _ready() -> void:
	_small_set()

func _small_set() -> void:
	var texture_name: StringName
	if small:
		texture_name = "small_cloud"
		collision_shape_2d.shape.set_size(Vector2(22, 12))
	else:
		texture_name = "big_cloud"
		collision_shape_2d.shape.set_size(Vector2(30, 14))
			
	sprite_2d.texture = load("res://Entities/OneWayCloud/" + texture_name + ".png")
