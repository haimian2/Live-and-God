extends Node2D

@onready var player: Player = %Player

func _ready() -> void:
	if !GlobalData.global_data.is_empty():
		player.set_player_texture(GlobalData.global_data["vampire_survival_init"]["character"].texture)
		player.init_ability(GlobalData.global_data["vampire_survival_init"]["skill"])
	$SceneMusic.play()
