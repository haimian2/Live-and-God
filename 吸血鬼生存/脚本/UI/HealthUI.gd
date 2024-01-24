extends ProgressBar

@export var health_component:HealthComponent

func _ready() -> void:
	health_component.updated_health.connect(on_updated_health)
	
func on_updated_health(max_health:int,current_health:int)->void:
	max_value = max_health
	value = current_health
	
