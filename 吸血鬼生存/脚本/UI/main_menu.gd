extends CanvasLayer

@onready var resume_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var options_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/OptionsButton
@onready var exit_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ExitButton
@onready var restart_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton
const ENSURE_EXIT = preload("res://吸血鬼生存/场景/UI/ensure_exit.tscn")
const ENSURE_RESTART = preload("res://吸血鬼生存/场景/UI/ensure_restart.tscn")
const OPTIONS_MENU = preload("res://吸血鬼生存/场景/UI/options_menu.tscn")

func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	exit_button.pressed.connect(on_exit_button_pressed)
	restart_button.pressed.connect(on_restart_button_pressed)
	layer = -100
	visible = false
	
func on_resume_button_pressed():
	visible = false
	layer = -100
	get_tree().paused = false
	
func on_options_button_pressed():
	var options_menu = OPTIONS_MENU.instantiate()
	add_child(options_menu)
	options_menu.layer = 100
	visible = false
	
func on_restart_button_pressed():
	print(11)
	var ensure_restart = ENSURE_RESTART.instantiate()
	add_child(ensure_restart)
	ensure_restart.layer = 100
	visible = false
	
func on_exit_button_pressed():
	var ensure_exit = ENSURE_EXIT.instantiate()
	add_child(ensure_exit)
	ensure_exit.layer = 100
	visible = false
