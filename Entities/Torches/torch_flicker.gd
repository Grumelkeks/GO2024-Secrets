class_name TorchFlicker
extends PointLight2D

var noise : FastNoiseLite = FastNoiseLite.new()
var time_passed: float = 0

func _ready() -> void:
	noise.frequency = 0.3
	noise.seed = get_instance_id()

func _process(delta: float) -> void:
	time_passed += delta
	
	var sample_noise = noise.get_noise_1d(time_passed)
	texture_scale = 1 + (sample_noise * 0.5)
	
	energy = 1 + (sample_noise * 0.2)
