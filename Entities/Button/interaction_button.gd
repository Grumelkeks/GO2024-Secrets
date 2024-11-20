class_name SelfButton
extends Area2D

signal button_status_change(button: SelfButton)

@export var hold_duration: float = 0.1

var timer: Timer = Timer.new()

var pressed: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		pressed = true
		animated_sprite_2d.play("pressed")
		button_status_change.emit(self)


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		timer.start(hold_duration)

func _on_timer_timeout() -> void:
	print("hi")
	pressed = false
	animated_sprite_2d.play("default")
	button_status_change.emit(self)
