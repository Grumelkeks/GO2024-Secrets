extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

var elapsed: float = 0.0

var from_player: AudioStreamPlayer
var to_player: AudioStreamPlayer
var multiplier: float

func _ready() -> void:
	set_process(false)

func switch_music(to_num: int, to: AudioStream, m_multiplier: float) -> void:
	from_player = get_child(1-to_num)
	to_player = get_child(to_num)
	multiplier = m_multiplier
	to_player.stop()
	to_player.stream = to
	var time: float = from_player.get_playback_position()
	to_player.play(time)
	
	elapsed = 0.0
	set_process(true)

func _process(delta: float) -> void:
	from_player.volume_db = lerp(0, -18, elapsed)
	to_player.volume_db = lerp(-18, 0, elapsed)
	elapsed += (delta * multiplier)
	
	if elapsed > 1:
		from_player.stop()
		set_process(false)

func is_current_music(to_num):
	if get_child(to_num) == to_player:
		return true
	return false
