extends Base_State

@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var speed = owner.speed
@onready var floor_acceleration:float = owner.FLOOR_ACCELERATION
@onready var air_acceleration:float = owner.AIR_ACCELERATION
@onready var delay_jump: Node = owner.get_node("Delay_jump/CoyoteTimer")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter():
	animationPlayer.stop()
	animationPlayer.play("翻滚")
	
	
	
func do():
	if !owner.is_on_floor():
		get_parent().change_state(6)
		return
	var x:int = -1 if animated.flip_h else 1
	owner.velocity.x = move_toward(owner.velocity.x,x * owner.ROLL_SPEED,floor_acceleration * get_process_delta_time())
	owner.velocity.y += gravity * get_process_delta_time()
	var was_on_floor:bool = owner.is_on_floor()
	owner.move_and_slide()
	if owner.is_on_floor() != was_on_floor:
		delay_jump.start()
	else:
		delay_jump.stop()

func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "翻滚":
		var vec:Vector2 = Vector2.ZERO
		vec.x = Input.get_axis("move_left","move_right")
		if vec.x != 0:
			get_parent().change_state(1)
			return
		get_parent().change_state(0)
