class_name WallTorch
extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var torch_particles: CPUParticles2D = $TorchParticles
@onready var torch_light: PointLight2D = $TorchLight

var lit = false

var tween : Tween
var duration: float = 0.5

func _on_body_entered(body: Node2D) -> void:
	if not lit and body.name == "Player":
		if body.torch != null:
			lit = true
			animated_sprite_2d.play("lit")
			torch_particles.emitting = true
			
			if(tween):
				tween.kill()
			tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
			
			tween.tween_property(
				torch_light, "color", Color(1,1,1,1), duration)
