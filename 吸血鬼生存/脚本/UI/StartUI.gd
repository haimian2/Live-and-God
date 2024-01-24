extends CanvasLayer
class_name StartUI

@export var music:AudioStreamPlayer
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _process(delta: float) -> void:
	label.text = "%s" % int(timer.time_left)

func _on_timer_timeout() -> void:
	get_tree().paused = false
	music.play()
	visible = false
