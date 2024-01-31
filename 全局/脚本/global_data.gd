extends Node

var global_data:Dictionary = {}

func add_data(data:Dictionary):
	for i in data:
		global_data[i] = data[i]

func remove_data(data:Dictionary):
	for i in data:
		if global_data.has(i):
			global_data.erase(i)

func global_data_has_key(name:String)->bool:
	if global_data.has(name):
		return true
	return false
