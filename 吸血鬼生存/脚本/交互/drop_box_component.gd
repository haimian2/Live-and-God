extends Area2D
class_name DropBoxComponent

var experience_value:int

func _ready() -> void:
	area_entered.connect(process_area_entered)
	
func process_area_entered(area:Area2D)->void:
	if not area is PickBoxComponent:
		return
	owner.queue_free()
