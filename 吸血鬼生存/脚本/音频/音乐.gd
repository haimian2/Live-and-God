extends AudioStreamPlayer

@export var streams:Array[AudioStream]
@export var min_pitch:float = 0.9
@export var max_pitch:float = 1.1
@export var open_pitch = true

func play_random():
	if !streams || streams.size() == 0:
		return
	if open_pitch:
		pitch_scale = randf_range(min_pitch,max_pitch)
	else:
		pitch_scale = 1
	stream = streams.pick_random()
	play()
