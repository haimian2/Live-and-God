extends Node

signal experience_updated(current_experience:int,target_experience:int,current_level:int)
signal level_up(new_level:int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience:int = 0
var current_level:int = 0
var target_experience:int = 1

func _ready() -> void:
	GameEvents.experience_collected.connect(process_experience_collected)

func increment_experience(num:int)->void:
	current_experience += num
	experience_updated.emit(current_experience,target_experience,current_level)
	while current_experience >= target_experience:
		current_level += 1
		current_experience -= target_experience
		target_experience += TARGET_EXPERIENCE_GROWTH
		experience_updated.emit(current_experience,target_experience,current_level)
		level_up.emit(current_level)
		
func process_experience_collected(num:int)->void:
	increment_experience(num)
