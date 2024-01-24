extends Node2D

var experience_value:int = 1
@onready var drop_box_component: DropBoxComponent = $Sprite2D/DropBoxComponent
@onready var timer: Timer = $Timer
@onready var random_stream_player_2d_component: AudioStreamPlayer2D = $RandomStreamPlayer2DComponent

func _ready() -> void:
	drop_box_component.experience_value = experience_value
	drop_box_component.success_pick_up.connect(on_success_pick_up)
	timer.start()

func _on_timer_timeout() -> void:
	drop_box_component.monitorable = true
	drop_box_component.monitoring = true

func on_success_pick_up():
	random_stream_player_2d_component.play_random()
