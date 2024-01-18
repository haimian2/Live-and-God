extends Base_State


@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var animationPlayer = owner.get_node("AnimationPlayer")

func enter():
	animationPlayer.stop()
	animationPlayer.play("特殊攻击")
	
		
func do():
	pass
	
	
func attack_check():
	for i in owner.get_node("Attack_Check/SpecialAttackCheck").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)


func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "特殊攻击":
		var vec = Input.get_axis("move_left","move_right")
		if vec != 0:
			get_parent().change_state(1)
			return
		else:
			get_parent().change_state(0)
			return
