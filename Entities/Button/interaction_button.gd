class_name SelfButton
extends InteractionZone

signal button_status_change(button: SelfButton)
signal is_lit()

var once = false

@export var hold_duration: float = 0.1

var timer: Timer = Timer.new()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var already_lit = false

func _ready() -> void:
	super()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _perform_action(_player: Player) -> void:
	active = false
	animated_sprite_2d.play("pressed")
	if not once:
		once = true
		is_lit.emit()
	button_status_change.emit(self)

func _perform_action_deactivate(_player: Player) -> void:
	timer.start(hold_duration)

func _on_timer_timeout() -> void:
	active = true
	animated_sprite_2d.play("default")
	button_status_change.emit(self)
