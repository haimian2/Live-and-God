extends Area2D
class_name HitBoxComponent

var damage_value:int = 10
var hurtbox:HurtBoxComponent
@onready var timer: Timer = $Timer

func _ready() -> void:
	area_entered.connect(process_area_entered)
	area_exited.connect(process_area_exited)
	
func process_area_entered(area:Area2D)->void:
	if not area is HurtBoxComponent:
		return
	hurtbox = area as HurtBoxComponent
	timer.start()

func process_area_exited(area:Area2D)->void:
	if not area is HurtBoxComponent:
		return
	hurtbox = null
	timer.stop()

func _on_timer_timeout() -> void:
	hurtbox.health_component.damage(damage_value)
