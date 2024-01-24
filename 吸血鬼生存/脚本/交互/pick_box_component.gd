extends Area2D
class_name PickBoxComponent

func _ready() -> void:
	area_entered.connect(process_area_enter)
	
func process_area_enter(area:Area2D)->void:
	if not area is DropBoxComponent:
		return
	var dropbox = area as DropBoxComponent
