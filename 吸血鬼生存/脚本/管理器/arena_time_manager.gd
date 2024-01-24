extends Node
class_name ArenaTimeManager

signal update_time(second:int,minute:int)
signal update_difficulty(difficulty:float)

var minute:int = 0
var difficulty:float = 0

func _on_timer_timeout() -> void:
	minute += 1
	update_time.emit(minute / 60,minute % 60)
	if minute % 30 >= 29 && difficulty < 5.0:
		difficulty += 1
		update_difficulty.emit(difficulty)
