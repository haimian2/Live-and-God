extends Button

@onready var area_2d: Area2D = $Area2D
@onready var area_2d_2: Area2D = $Area2D2

func _ready() -> void:
	area_2d.area_entered.connect(on_area_entered)
	area_2d.area_exited.connect(on_area_exited)
	
func on_area_entered(area:Node2D):
	print(11)

func on_area_exited(area:Node2D):
	print(22)

func on_111():
	print(333)

func _on_pressed() -> void:
	area_2d_2.queue_free()
