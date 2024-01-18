extends PanelContainer

signal show_money()

@onready var label_2: Label = $MarginContainer/HBoxContainer/Label2

func _ready() -> void:
	show_money.connect(show_player_money)
	
func _process(delta: float) -> void:
	position = Vector2(get_window().get_visible_rect().end.x - size.x,0)
	
func show_player_money()->void:
	label_2.text = type_convert(owner.money,TYPE_STRING)
