extends Node

signal can_queue_free

@export var health_component:HealthComponent
@export var sprite:Sprite2D
@export var pixel_dissipation_material:ShaderMaterial
var pixel_dissipation_tween:Tween

func _ready() -> void:
	health_component.died.connect(on_died)
	sprite.material = pixel_dissipation_material
	
func on_died()->void:
	if pixel_dissipation_tween && pixel_dissipation_tween.is_valid():
		pixel_dissipation_tween.kill()
	(sprite.material as ShaderMaterial).set_shader_parameter("time",1.57)
	pixel_dissipation_tween = create_tween()
	pixel_dissipation_tween.tween_property(sprite.material,"shader_parameter/time",0.0,.25).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	pixel_dissipation_tween.tween_callback(emit_can_queue_free)
	
func emit_can_queue_free():
	can_queue_free.emit()
