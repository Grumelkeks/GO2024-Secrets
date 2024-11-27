extends AudioStreamPlayer
class_name PitchedAudioStreamPlayer

@export var min_pitch = 0.95
@export var max_pitch = 1.05

func _play(from = 0.0):
	self.pitch_scale = randf_range(min_pitch, max_pitch)
	self.play(from)
