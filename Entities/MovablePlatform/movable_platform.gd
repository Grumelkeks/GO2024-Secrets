@tool
class_name MovablePlatform
extends PathFollow2D

@export var wait_duration: float = 0.5
@export var duration: float = 10.0

var tween: Tween
var bounce_tween: Tween

@onready var sprite_2d: Sprite2D = $Platform/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Platform/CollisionShape2D

@export var campfire = false:
	set(value):
		campfire = value
		modulate = Color(1,1,1,0)
@export var small: bool = true:
	set(value):
		small = value
		if Engine.is_editor_hint():
			call_deferred("_small_set")

func _small_set() -> void:
	var texture_name: StringName
	if small:
		texture_name = "small_cloud"
		collision_shape_2d.shape.set_size(Vector2(22, 12))
	else:
		texture_name = "big_cloud"
		collision_shape_2d.shape.set_size(Vector2(30, 14))
			
	sprite_2d.texture = load("res://Entities/OneWayCloud/" + texture_name + ".png")


func _ready() -> void:
	if not Engine.is_editor_hint():
		_small_set()
		if campfire:
			if(tween):
				tween.kill()
			tween = create_tween().set_ease(Tween.EASE_IN)
			
			tween.tween_property(
				self, "modulate", Color(1,1,1,1), duration/20)
			tween.tween_property(
				self, "progress_ratio", 1, duration)
			tween.parallel().tween_property(
				self, "modulate", Color(1,1,1,0), duration)
			
			await(tween.finished)
			
			queue_free()
		else:
			_progress()

func _progress() -> void:
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(Tween.EASE_IN)
		
	tween.tween_property(
		self, "progress_ratio", 1, duration).set_delay(wait_duration)
	tween.tween_property(
		self, "progress_ratio", 0, duration).set_delay(wait_duration)
		
	await(tween.finished)
	
	_progress()

func bounce() -> void:
	if(bounce_tween):
		bounce_tween.kill()
	bounce_tween = create_tween().set_ease(Tween.EASE_IN)
	
	bounce_tween.tween_property(
		sprite_2d, "position:y", 3, 0.1)
	bounce_tween.tween_property(
		sprite_2d, "position:y", 0, 0.15)
