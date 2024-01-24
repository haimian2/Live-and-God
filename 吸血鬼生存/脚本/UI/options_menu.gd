extends CanvasLayer

@onready var back_button: Button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/BackButton
@onready var sfx_slider: HSlider = %SfxSlider
@onready var music_slider: HSlider = %MusicSlider

func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)
	sfx_slider.value = get_bus_volumn_percent("音乐")
	music_slider.value = get_bus_volumn_percent("音效")
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("音乐"))
	music_slider.value_changed.connect(on_audio_slider_changed.bind("音效"))

func get_bus_volumn_percent(bus_name:String):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volumn_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volumn_db)

func set_bus_volumn_percent(bus_name:String,percent:float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var volumn_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index,volumn_db) 

func on_back_button_pressed():
	if get_parent():
		get_parent().visible = true
	queue_free()

func on_audio_slider_changed(value:float,bus_name:String):
	set_bus_volumn_percent(bus_name,value)
