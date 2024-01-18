extends CharacterBody2D

signal player_attack(player:Object)

@onready var timer: Timer = $Timer

const EXPERIENCE = preload("res://吸血鬼生存/场景/experience.tscn")
const SPEED = 50
var be_attacked:bool = false
var damage:int = 5
var player:Node2D = null

func _ready() -> void:
	player_attack.connect(process_player_attck)

func _physics_process(delta: float) -> void:
	var direction = get_direction_to_player()
	if be_attacked:
		var ex = EXPERIENCE.instantiate()
		ex.global_position = global_position
		get_parent().get_parent().get_node("DropObject").add_child(ex)
		queue_free()
	velocity = direction * SPEED
	move_and_slide()

func get_direction_to_player()->Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

func process_player_attck(player:Object)->void:
	be_attacked = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.monster_attack.emit(self)
		player = body
		timer.start()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.stop()

func _on_timer_timeout() -> void:
	if player:
		player.monster_attack.emit(self)
