extends AudioStreamPlayer

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_timeout)
	finished.connect(on_finished)
	
func on_finished():
	timer.start()
	
func on_timeout():
	play()
