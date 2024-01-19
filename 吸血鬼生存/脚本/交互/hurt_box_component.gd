extends Area2D
class_name HurtBoxComponent

@export var health_component:HealthComponent

func _ready() -> void:
	area_entered.connect(process_area_entered)

func process_area_entered(area:Area2D)->void:
	if not area is HitBoxComponent:
		return
	if !health_component:
		return
	var hitboxcomponent = area as HitBoxComponent
	health_component.damage(hitboxcomponent.damage_value)
