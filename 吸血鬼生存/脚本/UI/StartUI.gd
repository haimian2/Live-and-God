extends CanvasLayer
class_name StartUI

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _process(delta: float) -> void:
	label.text = "%s" % int(timer.time_left)

func _on_timer_timeout() -> void:
	get_tree().paused = false
	visible = false
