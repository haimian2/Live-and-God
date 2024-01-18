extends Node2D

signal change_text()

@export var text:String

func _ready() -> void:
	change_text.connect(set_text)
	$Label.visible = false
	
func set_text():
	$Label.text = text

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.text = text
		$Label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.text = text
		$Label.visible = false
