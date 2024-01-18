extends Line2D

var Arc:int = 80
var RandRange:int = 10
var DivisionTimes:int = 80
var LightingPath:Array
var LightSpeed:float = 0.002

var DivisionPath:Array

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func set_lighting():
	self.modulate = Color(1,1,1,1)
	LightingPath.clear()
	
	LightingPath.append($PosA.global_position)
	
	for i in Arc - 2:
		LightingPath.append(LightingPath.back() + (($PosB.global_position - LightingPath.back()) / (Arc - i - 1)) - Vector2(randf_range(-RandRange,RandRange),randf_range(-RandRange,RandRange)))
		if LightSpeed != 0 :
			await get_tree().create_timer(LightSpeed).timeout
	
	LightingPath.append($PosB.global_position)
	
	await get_tree().create_timer(0.05).timeout
	var disapper1 = get_tree().create_tween()
	disapper1.tween_property(self,"modulate",Color(0,0,0,1),0.5).from(Color(1,1,1,1)).set_trans(Tween.TRANS_LINEAR)

	await get_tree().create_timer(0.2).timeout
	var light = get_tree().create_tween()
	light.tween_property(self,"modulate",Color(1,1,1,1),0.3).from(Color(50,40,40,1)).set_trans(Tween.TRANS_LINEAR)
	
	await get_tree().create_timer(0.1).timeout
	var disapper2 = get_tree().create_tween()	
	disapper2.tween_property(self,"modulate",Color(0,0,0,0),1).from(Color(1,1,1,1)).set_trans(Tween.TRANS_LINEAR)
