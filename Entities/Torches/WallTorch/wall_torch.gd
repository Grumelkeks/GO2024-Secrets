class_name WallTorch
extends InteractionZone

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var torch_particles: CPUParticles2D = $TorchParticles
@onready var torch_light: PointLight2D = $TorchLight

signal is_lit()

var tween : Tween
var duration: float = 0.5

var already_lit : bool = false

func _ready() -> void:
	super()
	for torch in EndingStorageGlobal.lit_torches:
		if torch == self.name:
			already_lit = true
			call_deferred("_action")

func _perform_action(player: Player) -> void:
	if player.torch != null:
		EndingStorageGlobal.lit_torches.append(self.name)
		_action()

func _action() -> void:
	active = false
	is_lit.emit()
	
	animated_sprite_2d.play("lit")
	torch_particles.emitting = true
	
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
	
	tween.tween_property(
		torch_light, "color", Color(1,1,1,1), duration)