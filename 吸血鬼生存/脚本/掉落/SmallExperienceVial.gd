extends Node2D

var experience_value:int = 1
@onready var drop_box_component: DropBoxComponent = $Sprite2D/DropBoxComponent
@onready var timer: Timer = $Timer

func _ready() -> void:
	drop_box_component.experience_value = experience_value
	timer.start()

func _on_timer_timeout() -> void:
	drop_box_component.monitorable = true
	drop_box_component.monitoring = true
