extends Sprite2D

signal process_player_interact(player:Object)

func _ready() -> void:
	process_player_interact.connect(process_interact)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_E_KEY(self,true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_E_KEY(null,false)
		
func process_interact(player:Object)->void:
	SceneChanger.change_scene("res://自然系统/场景/thunder_rainy_day.tscn",true)
