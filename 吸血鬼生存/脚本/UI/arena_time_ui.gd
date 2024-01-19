extends CanvasLayer

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $MarginContainer/Label/Timer

var second:int = 0

func _process(delta: float) -> void:
	label.text = "\n" + str("%02d" % second) + ":" + ("%02d" % (timer.wait_time - timer.time_left))

func _on_timer_timeout() -> void:
	second += 1
