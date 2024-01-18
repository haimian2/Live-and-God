extends Base_State

@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")


func enter():
	animation.play("向左静止")

func do():
	pass
