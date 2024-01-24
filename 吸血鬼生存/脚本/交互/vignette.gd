extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var player:Player

func _ready() -> void:
	player.player_be_attack.connect(on_player_be_attack)

func on_player_be_attack():
	animation_player.play("受击")
