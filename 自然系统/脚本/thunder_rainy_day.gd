extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rainy_day: CPUParticles2D = $RainyDay
@onready var lightning: Sprite2D = $Lightning
@onready var lightning_2: Sprite2D = $Lightning2
@onready var flash: Sprite2D = $Flash

func _ready() -> void:
	animation_player.play("雷雨")

func set_rainy_day(pos:Vector2,end:Vector2)->void:
	#rainy_day.position = Vector2(position.x + get_window().get_visible_rect().end.x / 2,position.y - 10)
	rainy_day.amount = abs(pos.x - end.x) / 2160 * 800
	rainy_day.position = Vector2((pos.x + end.x) / 2,pos.y - get_window().get_visible_rect().end.y / 2)
	rainy_day.emission_rect_extents.x = abs(pos.x - end.x)
	rainy_day.lifetime = abs(pos.y - end.y) / rainy_day.gravity.y + 1
	
func rand_lightning_position()->void:
	var win_pos:Vector2 = get_window().get_visible_rect().end
	lightning.position = Vector2(randi_range(flash.position.x,flash.scale.x),flash.position.y)
	lightning.rotation = tanh(randi_range(lightning.offset.x,abs(lightning.offset.x)) / lightning.get_rect().size.y)
	lightning_2.position = Vector2(randi_range(flash.position.x,flash.scale.x),flash.position.y)
	lightning_2.rotation = tanh(randi_range(lightning.offset.x,abs(lightning.offset.x)) / lightning.get_rect().size.y)

func flash_position(beg:Vector2,end:Vector2)->void:
	flash.position = beg
	flash.position.y -= get_window().get_visible_rect().end.y / 12 * 5
	flash.scale = end
