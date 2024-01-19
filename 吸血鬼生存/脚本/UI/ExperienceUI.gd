extends CanvasLayer
class_name ExperienceUI

signal increase_experience(exe:int)

@export var experience_manager:Node
@onready var progress_bar: ProgressBar = $MarginContainer/ProgressBar
@onready var label: Label = $MarginContainer/Label


func _ready() -> void:
	progress_bar.max_value = 10
	progress_bar.value = 0
	label.text = "等级 : 0"	
	experience_manager.experience_updated.connect(process_experience_updated)

func process_experience_updated(current_experience:int,target_experience:int,current_level:int)->void:
	progress_bar.max_value = target_experience
	progress_bar.value = current_experience
	label.text = "等级 : %s" % current_level
