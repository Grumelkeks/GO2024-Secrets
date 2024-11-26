class_name RoastExit
extends InteractionZone

@export var ending: Ending
@export var roast_time: float = 4.0

@onready var roast_timer: Timer = $RoastTimer

var entered: bool = false

func _ready() -> void:
	roast_timer.timeout.connect(_on_roast_timer_timeout)

func _perform_action(player: Player) -> void:
	roast_timer.start(roast_time)
	entered = true

func _perform_action_deactivate(player: Player) -> void:
	roast_timer.stop()
	entered = false

func _on_roast_timer_timeout() -> void:
	if entered:
		EndingStorageGlobal.endings[ending.storage_pos] = ending
		CameraTransition.camera_end_zoom()
