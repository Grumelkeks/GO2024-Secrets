extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

var tween : Tween

func switch_music(to: AudioStream, duration: float) -> void:
	
	if _check_audio_player(audio_stream_player, audio_stream_player_2, to, duration): return
	elif _check_audio_player(audio_stream_player_2, audio_stream_player, to, duration): return

func _check_audio_player(audio_player: AudioStreamPlayer, old_audio_player: AudioStreamPlayer, to: AudioStream, duration: float) -> bool:
	if not audio_player.playing:
			audio_player.stream = to
			audio_player.volume_db = -18
			var time: float = old_audio_player.get_playback_position()
			audio_player.play(time)
			_set_tween(audio_player, old_audio_player, duration)
	return false

func _set_tween(audio_player: AudioStreamPlayer, old_audio_player: AudioStreamPlayer, duration: float):
	if(tween):
		tween.kill()
	tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_parallel(true)
	
	tween.tween_property(
		old_audio_player, "volume_db", -18, duration)
	tween.tween_property(
		audio_player, "volume_db", 0, duration)
	
	await(tween.finished)
	old_audio_player.playing = false

func current_music() -> AudioStream:
	for child: AudioStreamPlayer in get_children():
		if child.playing:
			return child.stream
	return null
