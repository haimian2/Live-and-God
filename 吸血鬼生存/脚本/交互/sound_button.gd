extends Button

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	pressed.connect(on_pressed)
	
func on_pressed():
	audio_stream_player.play_random()
