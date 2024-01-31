extends Node2D

@export var weapons_scene:PackedScene

var array:Array = []

func add_weapons()->void:
	var weapons = weapons_scene.instantiate()
	add_child(weapons)
	array.push_back(weapons)
	for i in range(0,array.size()):
		(array[i] as Node2D).position = Vector2.UP.rotated(i * (TAU / array.size())) * 15
