extends Area2D
class_name DropBoxComponent

signal success_pick_up

@onready var sprite_2d: Sprite2D = $".."
var experience_value:int

func _ready() -> void:
	area_entered.connect(process_area_entered)
	
func tween_collect(percent:float,start_position:Vector2):
	var player = get_tree().get_first_node_in_group("player")
	if !player:
		return
	owner.global_position = start_position.lerp(player.global_position,percent)
	var direction_from_start = player.global_position - start_position
	var target_rotation = direction_from_start.angle() + deg_to_rad(90)
	owner.rotation = lerp_angle(owner.rotation,target_rotation,1 - exp(-2 * get_process_delta_time()))
	
func collect():
	GameEvents.emit_experience_collected(experience_value)
	owner.queue_free()
	
func disable_collision():
	$CollisionShape2D.disabled = true
	
func process_area_entered(area:Area2D)->void:
	if not area is PickBoxComponent:
		return
	Callable(disable_collision).call_deferred()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(owner.global_position),0.0,1.0,.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(owner,"scale",Vector2.ZERO,.05).set_delay(.45)
	tween.chain()
	tween.tween_callback(collect)
	success_pick_up.emit()
