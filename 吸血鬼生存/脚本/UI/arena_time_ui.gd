extends CanvasLayer

@onready var label: Label = $MarginContainer/Label
@export var arena_time_manager:ArenaTimeManager

func _ready() -> void:
	arena_time_manager.update_time.connect(on_update_time)
	label.text = "\n" + str("%02d" % 0) + ":" + ("%02d" % 0)
	
func on_update_time(second:int,minute:int) -> void:
	label.text = "\n" + str("%02d" % second) + ":" + ("%02d" % minute)

