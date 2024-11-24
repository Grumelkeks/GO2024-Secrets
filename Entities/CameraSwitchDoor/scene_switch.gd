class_name CameraSwitch
extends InteractionZone

var from : Camera2D
var to : Camera2D
var multiplier : float = 1.0

var to_music : AudioStream

func _perform_action(player: Player) -> void:
	if(CameraTransition.transitioning == true):
		CameraTransition.interfere_transition(from, to)
	elif from.is_current():
		CameraTransition.transition_camera(player, from, to, multiplier)
	if to_music != null:
		MusicPlayer.switch_music(to_music, 1/multiplier)
