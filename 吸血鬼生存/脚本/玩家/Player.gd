extends CharacterBody2D
class_name Player

signal player_died
signal player_be_attack

@export var game_over_ui:GameOverUI
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var velocity_component: VelocityConponent = $%VelocityComponent
@onready var health_component: HealthComponent = $%HealthComponent
@onready var random_stream_player_2d_component: AudioStreamPlayer2D = $RandomStreamPlayer2DComponent
var base_speed:int = 90
var base_accelerate:int = 25
var speed_percent:float = 0
var accelerate_percent:float = 0

func _ready() -> void:
	health_component.died.connect(on_died)
	health_component.reduce_health.connect(on_reduce_health)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	velocity_component.max_speed = base_speed * (1 - speed_percent)
	velocity_component.acceleration = base_accelerate * (1 - accelerate_percent)

func _physics_process(delta: float) -> void:
	var x_move := Input.get_axis("move_left", "move_right")
	var y_move := Input.get_axis("move_up","move_down")
	var direction = Vector2(x_move,y_move).normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	if velocity.x < 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false

func on_died()->void:
	player_died.emit()
 
func on_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	if upgrade is Ability:
		var ability = upgrade as Ability
		$%Abilities.add_child(ability.ability_scene.instantiate())
	elif upgrade.id == "player_speed":
		speed_percent = current_upgrades["player_speed"]["quantity"] * .1
		velocity_component.max_speed = base_speed * (1 - speed_percent)
		
func on_reduce_health():
	player_be_attack.emit()
	random_stream_player_2d_component.play_random()
