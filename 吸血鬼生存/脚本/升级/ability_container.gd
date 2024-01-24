extends PanelContainer

signal selected

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var description_label: Label = $VBoxContainer/DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var hover_audio: AudioStreamPlayer = $HoverAudio
@onready var select_audio: AudioStreamPlayer = $SelectAudio
var disabled:bool = false

func _ready() -> void:
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	
func play_in(delay:float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	animation_player.play("淡入")
	
func play_out():
	animation_player.play("丢弃")
	
func set_ability_upgrade(upgrade:AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	
func select_card():
	disabled = true
	animation_player.play("选择")
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		other_card.play_out()
	await animation_player.animation_finished
	selected.emit()

func on_gui_input(event:InputEvent)->void:
	if disabled:
		return
	if event.is_action_pressed("mouse_left"):
		select_card()

func on_mouse_entered()->void:
	animation_player_2.play("鼠标悬停")
	hover_audio.play_random()
	
func on_mouse_exited()->void:
	animation_player_2.stop()
