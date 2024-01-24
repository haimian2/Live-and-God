extends Node2D

@onready var hit_box_component: HitBoxComponent = $Sprite2D/HitBoxComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var MAX_RADIUS = 100
var base_rotation = Vector2.RIGHT

func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0,TAU))

func play_rotation(damage_value:int = 10)->void:
	hit_box_component.damage_value = damage_value
	animation_player.play("环绕攻击")
	var tween = create_tween()
	tween.tween_method(tween_method,0.0,2.0,3)
	tween.tween_callback(queue_free)
	
func tween_method(rotations:float)->void:
	var percent = rotations / 2
	var current_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var base_position = Vector2.ZERO
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
		
	base_position = player.global_position
	global_position = base_position + (current_direction * current_radius)
