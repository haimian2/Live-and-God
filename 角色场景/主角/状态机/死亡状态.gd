extends Base_State

@onready var animationPlayer = owner.get_node("AnimationPlayer")
@onready var animation = owner.get_node("AnimatedSprite2D")


func enter():
	animationPlayer.stop()
	owner.get_node("CollisionShape2D").queue_free()
	owner.get_node("Attack_Check").queue_free()
	animationPlayer.play("死亡")
	
	
func do():
	pass


func _on_animated_sprite_2d_animation_finished():
	if animation.animation == "死亡":
		owner.queue_free()
