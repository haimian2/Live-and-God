extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var loading_path = ""

func _ready() -> void:
	self.hide()
	
func change_scene(path,isLoading:bool = false,isLoadingPath:bool = false)->void:
	self.show()
	self.set_layer(100)
	if isLoadingPath:
		$ColorRect.material.set_shader_parameter("cutoff",0)
	else:
		animation_player.play("scene_change_3")
		await animation_player.animation_finished
	if isLoading:
		loading_path = path
		get_tree().change_scene_to_file("res://场景切换/场景/page_loading.tscn")
	else:
		if typeof(path) == TYPE_STRING:
			get_tree().change_scene_to_file(path)
		else:
			get_tree().change_scene_to_packed(path)
	if isLoading:
		$ColorRect.material.set_shader_parameter("cutoff",1)
	else:
		animation_player.play_backwards("scene_change_3")
		await animation_player.animation_finished
	self.set_layer(-100)
	self.hide()
