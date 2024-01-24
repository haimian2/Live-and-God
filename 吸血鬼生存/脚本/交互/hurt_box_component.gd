extends Area2D
class_name HurtBoxComponent

@export var health_component:HealthComponent
@export var float_text:PackedScene
@onready var delay_damage_timer: Timer = $DelayDamageTimer
var all_damage:int = 0

func _ready() -> void:
	area_entered.connect(process_area_entered)
	area_exited.connect(on_area_exited)
	delay_damage_timer.timeout.connect(on_time_out)

func generate_float_text(damage_value:int)->void:
	var ft = float_text.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(ft)
	ft.global_position = global_position + Vector2.UP * 16
	ft.start(str(damage_value))

func process_area_entered(area:Area2D)->void:
	if not area is HitBoxComponent:
		return
	if !health_component:
		return
	var hitboxcomponent = area as HitBoxComponent
	all_damage += hitboxcomponent.damage_value
	health_component.damage(hitboxcomponent.damage_value)
	generate_float_text(hitboxcomponent.damage_value)
	delay_damage_timer.start()

func on_area_exited(area:Area2D)->void:
	if not area is HitBoxComponent:
		return
	if !health_component:
		return
	var hitboxcomponent = area as HitBoxComponent
	all_damage -= hitboxcomponent.damage_value
	
func on_time_out()->void:
	if all_damage == 0 or !delay_damage_timer.is_stopped():
		return
	health_component.damage(all_damage)
	generate_float_text(all_damage)
	delay_damage_timer.start()
