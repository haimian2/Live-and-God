extends Node

@onready var panel_container: PanelContainer = $MenuUI/PanelContainer

func _ready() -> void:
	panel_container.visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_menu"):
		get_tree().paused = !get_tree().paused
		var win_pos = get_window().get_visible_rect()
		panel_container.position = Vector2(win_pos.end.x / 2 - panel_container.size.x/ 2,win_pos.end.y / 2 - panel_container.size.y / 2)
		panel_container.visible = !panel_container.visible

func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	panel_container.visible = false

func _on_mainmenu_button_pressed() -> void:
	print('mainmenu')



func _on_break_button_pressed() -> void:
	print('break')
