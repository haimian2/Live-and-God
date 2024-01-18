extends DirectionalLight2D

@export var per_time = 60
@export var variation_time = 30

enum{
	MORNING,
	DAY,
	EVENING,
	NIGHT
}

@onready var morning_timer: Timer = $morningTimer
@onready var day_timer: Timer = $dayTimer
@onready var evening_timer: Timer = $eveningTimer
@onready var night_timer: Timer = $nightTimer
@onready var label: Label = $TimeUI/PanelContainer/MarginContainer/Label
@onready var panel_container: PanelContainer = $TimeUI/PanelContainer

func _ready() -> void:
	morning_timer.wait_time = per_time * 6
	day_timer.wait_time = per_time * 6
	evening_timer.wait_time = per_time * 6
	night_timer.wait_time = per_time * 6
	moring_state()
	morning_timer.start()
	panel_container.position = Vector2(get_window().get_visible_rect().end.x / 2,0)
	
func _process(delta: float) -> void:
	var times:int = 0
	if morning_timer.time_left > 0:
		times = night_timer.wait_time + morning_timer.wait_time - morning_timer.time_left
	elif day_timer.time_left > 0:
		times = night_timer.wait_time + morning_timer.wait_time + day_timer.wait_time - day_timer.time_left
	elif evening_timer.time_left > 0:
		times = night_timer.wait_time + morning_timer.wait_time + day_timer.wait_time + evening_timer.wait_time - evening_timer.time_left
	elif night_timer.time_left > 0:
		times = night_timer.wait_time - night_timer.time_left
	label.text = "%s : %s" % ["%0*d" % [2, times / 60],"%0*d" % [2, times % 60]]
	panel_container.position = Vector2(get_window().get_visible_rect().end.x / 2 - panel_container.size.x / 2,0)
	
func moring_state():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"energy",0.3,variation_time)
	
func day_state():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"energy",0,variation_time)
	
func evening_state():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"energy",0.7,variation_time)
	
func night_state():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"energy",0.9,variation_time)

func _on_morning_timer_timeout() -> void:
	day_state()
	day_timer.start()

func _on_day_timer_timeout() -> void:
	evening_state()
	evening_timer.start()

func _on_evening_timer_timeout() -> void:
	night_state()
	night_timer.start()
	
func _on_night_timer_timeout() -> void:
	moring_state()
	morning_timer.start()
