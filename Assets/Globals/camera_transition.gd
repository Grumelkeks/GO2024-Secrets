extends Node

signal transition_finished
signal zoom_finished

@onready var camera: Camera2D = $Camera2D

const WIDTH: float = 480
const HEIGHT: float = 270

const ZOOM_MULTIPLIER: float = 1
const WAIT_DURATION: float = 1
var end_cam: Camera2D
@onready var zoom_wait_timer: Timer = $ZoomWaitTimer


var transitioning = false

var player: Player
var from: Camera2D
var from_pos: Vector2
var to: Camera2D
var multiplier: float

var elapsed: float = 0.0

func _ready() -> void:
	set_process(false)
	zoom_wait_timer.timeout.connect(_on_zoom_wait_timer_timeout)


func transition_camera(m_player: Player, m_from: Camera2D, m_to: Camera2D, m_multiplier: float) -> void:
	if transitioning:
		return
	transitioning = true
	
	player = m_player
	from = m_from
	from_pos = m_from.global_position
	to = m_to
	multiplier = m_multiplier
	
	camera.zoom = m_from.zoom
	camera.offset = m_from.offset
	
	if m_from.global_position.x < m_from.limit_left + WIDTH/2:
		from_pos.x = m_from.limit_left + WIDTH/2
	if m_from.global_position.x > m_from.limit_right - WIDTH/2:
		from_pos.x = m_from.limit_right - WIDTH/2
	if m_from.global_position.y < m_from.limit_top + HEIGHT/2:
		from_pos.y = m_from.limit_top + HEIGHT/2
	if m_from.global_position.y > m_from.limit_bottom - HEIGHT/2:
		from_pos.y = m_from.limit_bottom - HEIGHT/2
	
	camera.global_position = from_pos
	
	camera.make_current()
	var remote_transform = player.get_node("CameraTransform")
	remote_transform.set_remote_node(remote_transform.get_path_to(to))
	
	to.position_smoothing_enabled = false
	elapsed = 0.0
	set_process(true)
	

func interfere_transition(m_from: Camera2D, m_to: Camera2D) -> void:
	set_process(false)
	from_pos = m_from.global_position
	
	if m_from.global_position.x < m_from.limit_left + WIDTH/2:
		from_pos.x = m_from.limit_left + WIDTH/2
	if m_from.global_position.x > m_from.limit_right - WIDTH/2:
		from_pos.x = m_from.limit_right - WIDTH/2
	if m_from.global_position.y < m_from.limit_top + HEIGHT/2:
		from_pos.y = m_from.limit_top + HEIGHT/2
	if m_from.global_position.y > m_from.limit_bottom - HEIGHT/2:
		from_pos.y = m_from.limit_bottom - HEIGHT/2
	
	camera.global_position = from_pos
	
	to = m_to
	elapsed = 1-elapsed
	set_process(true)

func _process(delta: float) -> void:
	var to_global_position = to.global_position
	
	if to.global_position.x < to.limit_left + WIDTH/2:
		to_global_position.x = to.limit_left + WIDTH/2
	if to.global_position.x > to.limit_right - WIDTH/2:
		to_global_position.x = to.limit_right - WIDTH/2
	if to.global_position.y < to.limit_top + HEIGHT/2:
		to_global_position.y = to.limit_top + HEIGHT/2
	if to.global_position.y > to.limit_bottom - HEIGHT/2:
		to_global_position.y = to.limit_bottom - HEIGHT/2
	
	camera.global_position = lerp(from_pos, to_global_position, pow(elapsed, 1.5))
	camera.zoom = lerp(from.zoom, to.zoom, pow(elapsed, (1.5 + 3*elapsed)))
	elapsed += (delta * multiplier)
	
	if elapsed > 1:
		if is_instance_valid(player):
			to.make_current()
			to.position_smoothing_enabled = true
		
			transitioning = false
			transition_finished.emit()
			set_process(false)

func camera_end_zoom() -> void:
	player = get_parent().get_node("StartArea").get_node("Player")
	player.get_tree().paused = true
	transition_camera(player, _current_cam(), end_cam, ZOOM_MULTIPLIER)
	
	await(transition_finished)
	
	zoom_wait_timer.start(WAIT_DURATION)

func _on_zoom_wait_timer_timeout() -> void:
	zoom_finished.emit()

func _current_cam() -> Camera2D:
	var cam: Camera2D
	
	var cameras: Node = get_parent().get_node("StartArea").get_node("Cameras")
	for child: Camera2D in cameras.get_children():
		if child.name == "EndCamera":
			end_cam = child
		if child.is_current():
			cam = child
			return cam
	
	return null
