extends Base_State

@onready var animated = owner.get_node("AnimatedSprite2D")
@onready var animationPlayer = owner.get_node("AnimationPlayer")


func enter():
	animationPlayer.stop()
	if owner.cur_health > 0:
		animationPlayer.play("受击")
	else:
		get_parent().change_state(4)
		
func do():
	pass


func _on_animated_sprite_2d_animation_finished():
	if animated.animation == "受击":
		get_parent().change_state(0)
		return
