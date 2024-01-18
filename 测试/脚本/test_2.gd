extends Button

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	SceneChanger.change_scene("res://地图/场景/地图二.tscn",true)
