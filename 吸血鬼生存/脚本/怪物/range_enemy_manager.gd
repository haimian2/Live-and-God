extends Node2D
class_name RangeEnemyManager

@export var player:Node2D
@onready var collision_shape_2d: CollisionShape2D = $CheckEnemy/CollisionShape2D
var enemys:Dictionary = {}
var _radius:int = 50
var radius:
	get:
		return _radius
	set(value):
		collision_shape_2d.shape.radius = value
		_radius = value
var _latest_enemy_info:Dictionary = {}
var latest_enemy_info:Dictionary:
	get:
		var ins:int =  100000
		_latest_enemy_info.erase("global_position")
		for item in enemys:
			var e_ins = sqrt(enemys[item].global_position.distance_squared_to(player.global_position))
			if e_ins < ins:
				_latest_enemy_info["global_position"] = enemys[item].global_position
				ins = e_ins
		return _latest_enemy_info
	set(value):
		_latest_enemy_info = value

func add_enemy(ele:Node2D):
	if !enemys.has(ele.e_id):
		enemys[ele.e_id] = ele
	else:
		call_deferred("queue_free")
		enemys[ele.e_id] = ele
	
func remove_enemy(ele:Node2D):
	if !enemys.has(ele.e_id):
		return
	enemys.erase(ele.e_id)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):
		add_enemy(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("monster"):
		remove_enemy(body)
