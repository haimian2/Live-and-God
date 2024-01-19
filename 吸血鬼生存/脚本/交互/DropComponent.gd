extends Node

@export var drop_scene:PackedScene
@export var health_component:HealthComponent
@export_range(0,1) var experience_drop_percent:float = .75

func _ready() -> void:
	health_component.died.connect(process_died)
	
func process_died()->void:
	if randf() > experience_drop_percent:
		return
	if !drop_scene:
		return
	if !owner:
		return
	var spawn_position = (owner as Node2D).global_position
	var drop_instance = drop_scene.instantiate() as Node2D
	owner.get_parent().add_child(drop_instance)
	drop_instance.global_position = spawn_position
