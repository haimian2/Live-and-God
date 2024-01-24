extends Node
class_name HealthComponent

signal died
signal updated_health(max_health:int,current_health:int)
signal reduce_health

@export var max_health:float = 10
var current_health:float

func _ready() -> void:
	current_health = max_health

func damage(damage_value:float)->void:
	current_health = max(current_health - damage_value,0)
	Callable(check_death).call_deferred()
	updated_health.emit(max_health,current_health)
	
func check_death()->void:
	if current_health == 0:
		died.emit()
	else:
		reduce_health.emit()
