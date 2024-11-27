extends Node

@onready var music_stream_player: AudioStreamPlayer = $MusicStreamPlayer

func switch_music(to: String) -> void:
	if music_stream_player["parameters/switch_to_clip"] != to:
		music_stream_player["parameters/switch_to_clip"] = to
