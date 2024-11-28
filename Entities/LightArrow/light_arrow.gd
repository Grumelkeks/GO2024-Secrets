@tool
class_name LightArrow
extends PathFollow2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D

@onready var arrow_shoot: PitchedAudioStreamPlayer = $ArrowShoot

var elapsed: float = 0.0

func _ready() -> void:
	deactivate()

func _process(delta: float) -> void:
	elapsed += delta
	if elapsed > 1:
		elapsed = 0.0
		arrow_shoot.play()
	progress_ratio = elapsed
	point_light_2d.color = Color(1,1,1,1-(elapsed * 0.7))


func activate() -> void:
	#sprite_2d.visible = true
	point_light_2d.enabled = true
	set_process(true)
	arrow_shoot.play()

func deactivate() -> void:
	sprite_2d.visible = false
	point_light_2d.enabled = false
	set_process(false)
	elapsed = 0.0
