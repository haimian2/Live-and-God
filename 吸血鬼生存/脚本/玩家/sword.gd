extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_box_component: HitBoxComponent = $Sprite2D/HitBoxComponent

func play_flash(damage_value:int = 10)->void:
	hit_box_component.damage_value = damage_value
	animation_player.play("闪现攻击")	

func play_suround(damage_value:int = 10)->void:
	hit_box_component.damage_value = damage_value	
	animation_player.play("环绕攻击")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "闪现攻击":
		queue_free()
