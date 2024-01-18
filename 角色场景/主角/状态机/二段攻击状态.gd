extends Base_State

@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var animationPlayer = owner.get_node("AnimationPlayer")


func enter():
	animationPlayer.stop()
	owner.is_press_attack = false
	animationPlayer.play("二段攻击")
	
		
func do():
	if Input.is_action_just_pressed("move_attack"):
		owner.is_press_attack = true
	elif Input.get_axis("move_left","move_right") != 0:
			owner.is_press_attack = false
	
func attack_check_1():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_1").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)

func attack_check_2():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_2").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
	
func attack_check_3():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_3").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
	
func attack_check_4():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_4").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
	
func attack_check_5():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_5").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
	
func attack_check_6():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_6").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
	
func attack_check_7():
	for i in owner.get_node("Attack_Check/TwoAttackCheck_7").get_overlapping_bodies():
		if i.is_in_group("monster"):
			i.be_attack(100)
			

func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "二段攻击":
		if owner.is_press_attack:
			get_parent().change_state(9)
			return
		var vec:Vector2 = Vector2.ZERO
		vec.x = Input.get_axis("move_left","move_right")
		if vec.x != 0:
			get_parent().change_state(1)
			return
		else:
			get_parent().change_state(0)
			return
