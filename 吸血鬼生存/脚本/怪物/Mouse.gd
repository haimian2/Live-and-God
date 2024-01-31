extends CharacterBody2D

signal player_attack(damage:int)

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityConponent = $VelocityComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hit_stream_component: AudioStreamPlayer2D = $HitStreamComponent
@onready var pixel_dissipation_component: Node = $PixelDissipationComponent
var e_id:String

func _ready() -> void:
	e_id = UUID.get_uuid()
	health_component.died.connect(on_died)
	health_component.reduce_health.connect(on_reduce_health)
	pixel_dissipation_component.can_queue_free.connect(on_can_queue_free)
	
func _physics_process(delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	if sign(velocity.x) > 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false

func get_direction_to_player()->Vector2:
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

func on_died()->void:
	hit_stream_component.play_random()
	
func on_reduce_health():
	hit_stream_component.play_random()
	
func on_can_queue_free():
	call_deferred("queue_free")
