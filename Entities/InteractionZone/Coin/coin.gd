class_name Coin
extends InteractionZone

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var pickup_coin: PitchedAudioStreamPlayer = $pickupCoin

func _ready() -> void:
	super()
	for coin in EndingStorageGlobal.coins:
		if coin == self.name:
			queue_free()

func _perform_action(_player: Player) -> void:
	active = false
	animated_sprite_2d.modulate = Color(1,1,1,0)
	pickup_coin._play()
	EndingStorageGlobal.coin_pickup(self)
