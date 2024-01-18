extends Control

@onready var progress_bar: ProgressBar = $ProgressBar

var progress = []
var scene_load_status = 0
var progress_init_value = 20

func _ready() -> void:
	var pos = get_window().get_visible_rect().end
	progress_bar.position = Vector2(pos.x / 2 - progress_bar.size.x / 2,pos.y / 4 * 3)
	progress_bar.max_value = 100.0 + progress_init_value
	progress_bar.value = progress_init_value
	await get_tree().create_timer(0.5).timeout
	ResourceLoader.load_threaded_request(SceneChanger.loading_path)

func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(SceneChanger.loading_path,progress)
	progress_bar.value = progress_init_value + progress[0] * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		await get_tree().create_timer(0.5).timeout
		SceneChanger.change_scene(ResourceLoader.load_threaded_get(SceneChanger.loading_path),false,true)
