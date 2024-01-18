extends Base_State

@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var speed = owner.speed
@onready var jump_speed = owner.jump_speed
var jumping:bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter():
	animated.stop()
	animated.play("预跳跃")
	await animated.animation_finished
	if animated.animation == "预跳跃":
		animated.frame = 0
		owner.get_node("Audio/Jump").play()
		animated.play("跳跃")
		jumping = true
		owner.velocity.y = jump_speed
		
func do():
	if jumping:
		if owner.velocity.y > 0:
			get_parent().change_state(6)
			return
		var vec:Vector2 = Vector2.ZERO
		vec.x = Input.get_axis("move_left","move_right")
		if vec.x > 0:
			animated.flip_h = false
			owner.get_node("Attack_Check").scale.x = 1
		else:
			animated.flip_h = true
			owner.get_node("Attack_Check").scale.x = -1		
		owner.velocity.x = vec.x * speed * 1.2
		owner.velocity.y += gravity * 0.05
		owner.move_and_slide()
		
func exit():
	owner.velocity.y = 0
	jumping = false
