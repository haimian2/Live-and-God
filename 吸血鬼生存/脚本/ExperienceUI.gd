extends CanvasLayer
class_name ExperienceUI

signal increase_experience(exe:int)

@onready var label: Label = $Label
@onready var progress_bar: ProgressBar = $ProgressBar
var level:int = 0
var current_exe:int = 0
var max_exe:int = 10

func _ready() -> void:
	increase_experience.connect(process_increase_experience)
	progress_bar.max_value = max_exe
	progress_bar.value = current_exe
	
func _process(delta: float) -> void:
	progress_bar.value = current_exe
	label.text = "等级:%s" % [level]
	
func process_increase_experience(exe:int)->void:
	current_exe += exe
	upgrade_level()
	
func upgrade_level()->void:
	while current_exe >= max_exe:
		current_exe -= max_exe
		level += 1
