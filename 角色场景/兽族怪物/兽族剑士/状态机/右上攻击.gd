extends Base_State
class_name RightUpAttack


@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")


func enter():
	animationPlayer.play("右上攻击")


func do():
	pass
	
func attack_check():
	var arr:Array = owner.get_node("AttackCheck/RU").get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.be_attack(30)


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "右上攻击" and owner.get_node("AttackCheck/RU"):
		var arr:Array = owner.get_node("AttackCheck/RU").get_overlapping_bodies()
		for i in arr:
			if i.is_in_group("player"):
				$Timer.start(0.55)
				return
		get_parent().change_state(0)


func _on_timer_timeout():
	animationPlayer.play("右上攻击")
