extends Area2D
class_name HitBoxComponent

@export var damage_value:int = 10

func _ready() -> void:
	area_entered.connect(process_area_entered)
	area_exited.connect(process_area_exited)
	
func process_area_entered(area:Area2D)->void:
	if not area is HurtBoxComponent:
		return

func process_area_exited(area:Area2D)->void:
	if not area is HurtBoxComponent:
		return
