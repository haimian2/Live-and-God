extends Base_State
class_name Left_Run_State

@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")

var SPEED = 80
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direct:Vector2 = Vector2.LEFT

func enter():
	owner.get_node("AnimationPlayer").play("向左走")
	
func do():
	owner.get_node("LeftDownCast").force_raycast_update()
	if !is_instance_valid(owner.get_node("LeftDownCast").get_collider()):
		get_parent().change_state(0)
		return
	var LLarr:Array = owner.get_node("AttackCheck/LL").get_overlapping_bodies()
	if !LLarr.is_empty():
		for i in LLarr:
			if i.is_in_group("player"):
				get_parent().change_state(5)
				return
	var LUarr:Array = owner.get_node("AttackCheck/LU").get_overlapping_bodies()
	if !LUarr.is_empty():
		for i in LUarr:
			if i.is_in_group("player"):
				get_parent().change_state(4)
				return
	if is_instance_valid(owner.get_node("LeftCast").get_collider()):
		get_parent().change_state(0)
		return
	owner.velocity = direct * SPEED
	owner.velocity.y = gravity
	owner.move_and_slide()



func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "向左走":
		pass
