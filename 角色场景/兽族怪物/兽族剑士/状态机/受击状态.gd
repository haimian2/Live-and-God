extends Base_State


@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")


func enter():
	if owner.health > 0:
		owner.get_node("Audio/Be_Attack").play()
		animation.play("向右静止")
	else:
		get_parent().change_state(7)
		return
	
	
func do():
	pass


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "向右静止":
		get_parent().change_state(0)
		return
