class_name MovableWall
extends StaticBody2D

@export var conditions: Array[InteractionZone]
var lit: int

@export var from_pos: int = 0
@export var duration: float = 1.0

const TO_POS: float = -48

@onready var wall_sprite_2d: Sprite2D = $WallSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
var rand_gen = RandomNumberGenerator.new()
const PITCH_VARIATION = 0.4

var tween : Tween

func _ready() -> void:
	for condition in conditions:
		condition.is_lit.connect(_on_is_lit)
	wall_sprite_2d.region_rect.position.y -= from_pos * 16
	collision_shape_2d.scale.y -= (float(from_pos)/3)
	collision_shape_2d.position.y += from_pos * 8

func _on_is_lit() -> void:
	lit += 1
	if lit >= conditions.size():
		_on_all_lit()

func _on_all_lit() -> void:	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(
		Tween.EASE_OUT).set_parallel(true)
	
	tween.tween_property(
		wall_sprite_2d, "region_rect:position:y", TO_POS, duration)
	tween.tween_property(
		collision_shape_2d, "position:y", 0, duration)
	tween.tween_property(
		collision_shape_2d, "scale:y", 0, duration)
	
	var already_lit = true
	for child in conditions:
		if not child.already_lit:
			already_lit = false
			break
	
	if not already_lit:
		_play_audio()
	
	await(tween.finished)
	
	collision_shape_2d.disabled = true

func _play_audio() -> void:
	var rand_pitch = rand_gen.randf_range(-PITCH_VARIATION, PITCH_VARIATION)
	audio_stream_player_2d.pitch_scale += rand_pitch
	audio_stream_player_2d.play()
