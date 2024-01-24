extends CanvasLayer

@onready var yes_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/YesButton
@onready var no_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/NoButton

func _ready() -> void:
	yes_button.pressed.connect(on_yes_button_pressed)
	no_button.pressed.connect(on_no_button_pressed)
	
func on_yes_button_pressed():
	get_tree().quit()
	
func on_no_button_pressed():
	if get_parent():
		get_parent().visible = true
	queue_free()
