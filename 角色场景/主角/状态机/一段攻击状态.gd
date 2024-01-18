extends Base_State


@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var animationPlayer = owner.get_node("AnimationPlayer")

func enter():
	animationPlayer.stop()
	owner.is_press_attack = false
	animationPlayer.play("一段攻击")
	
		
func do():
	if Input.is_action_just_pressed("move_attack"):
		owner.is_press_attack = true
	elif Input.get_axis("move_left","move_right") != 0:
			owner.is_press_attack = false
	
	
func attack_check():
	for i in owner.get_node("Attack_Check/OneAttackCheck").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)


func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "一段攻击":
		if owner.is_press_attack:
			get_parent().change_state(8)
			return
		else:
			var vec:Vector2 = Vector2.ZERO
			vec.x = Input.get_axis("move_left","move_right")
			if vec.x != 0:
				get_parent().change_state(1)
				return
			else:
				get_parent().change_state(0)
				return
