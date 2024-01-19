extends PanelContainer

signal selected

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var description_label: Label = $VBoxContainer/DescriptionLabel

func _ready() -> void:
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade:AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description

func on_gui_input(event:InputEvent)->void:
	if event.is_action_pressed("mouse_left"):
		selected.emit()
