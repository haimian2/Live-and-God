extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):
		var player = get_tree().get_first_node_in_group("player")
		body.player_attack.emit(player)

func flash_attack()->void:
	animation_player.play("闪现攻击")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "闪现攻击":
		queue_free()
