extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Sprite2D/Area2D
@onready var timer: Timer = $Timer

var enemy:Node2D

func _ready() -> void:
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_exited)
	timer.timeout.connect(on_timeout)
	
func play_animation(angle)->void:
	var tween = create_tween()
	tween.tween_property(sprite_2d,"rotation",angle,0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(reset_position)
	tween.tween_callback(timer.start)
	
func reset_position():
	sprite_2d.rotation = 0

func on_body_entered(body:Node2D):
	if body.is_in_group("monster"):
		enemy = body
		if timer.is_stopped():
			var mid = sprite_2d.global_position.angle_to_point(body.global_position)
			play_animation(mid)

func on_body_exited(body:Node2D):
	if body.is_in_group("monster"):
		if enemy and body.e_id == enemy.e_id:
			enemy = null
		
func on_timeout():
	if enemy:
		var angle = Vector2.UP.angle_to(enemy.global_position - sprite_2d.global_position)
		play_animation(angle)
