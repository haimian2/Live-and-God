extends CharacterBody2D

signal monster_attack(mons:Object)
signal interact_experience(exe:int)

@onready var progress_bar: ProgressBar = $Health/ProgressBar

@export var experience_ui:ExperienceUI
@export var game_over_ui:GameOverUI

const SPEED = 125
const ACCELERATION_SMOOTHING = 25

var health:int = 1
var max_health:int = 100

func _ready() -> void:
	name
	monster_attack.connect(process_monster_attack)
	interact_experience.connect(process_interact_experience)
	progress_bar.max_value = max_health

func _process(delta: float) -> void:
	$Health/ProgressBar.value = health

func _physics_process(delta: float) -> void:
	var x_move := Input.get_axis("move_left", "move_right")
	var y_move := Input.get_axis("move_up","move_down")
	var direction = Vector2(x_move,y_move).normalized()
	var target_velocity = direction * SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()

func process_monster_attack(mons:Node2D)->void:
	health -= mons.damage
	if health <= 0:
		game_over_ui.player_died.emit(self)
		
func process_interact_experience(exe:int)->void:
	experience_ui.increase_experience.emit(exe)
	
func _on_pick_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("drop_experience"):
		experience_ui.increase_experience.emit(body.exe)
		body.queue_free()
