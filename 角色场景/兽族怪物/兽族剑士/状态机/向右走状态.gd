extends Base_State
class_name Right_Run_State

@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")

var SPEED = 80
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direct:Vector2 = Vector2.RIGHT

func enter():
	owner.get_node("AnimationPlayer").play("向右走")
	
func do():
	owner.get_node("RightDownCast").force_raycast_update()
	if !is_instance_valid(owner.get_node("RightDownCast").get_collider()):
		get_parent().change_state(1)
		return
	var RLarr:Array = owner.get_node("AttackCheck/RL").get_overlapping_bodies()
	if !RLarr.is_empty():
		for i in RLarr:
			if i.is_in_group("player"):
				get_parent().change_state(3)
				return
	var RUarr:Array = owner.get_node("AttackCheck/RU").get_overlapping_bodies()
	if !RUarr.is_empty():
		for i in RLarr:
			if i.is_in_group("player"):
				get_parent().change_state(2)
				return
	if is_instance_valid(owner.get_node("RightCast").get_collider()):
		get_parent().change_state(1)
		return
	owner.velocity = direct * SPEED
	owner.velocity.y = gravity
	owner.move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "向右走":
		pass
