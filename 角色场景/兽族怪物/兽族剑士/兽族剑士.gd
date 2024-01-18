extends CharacterBody2D


var health:int = 100
var have_be_attack:bool = false

func _ready():
	add_to_group("monster")
	
	
func be_attack(value:int):
	health = health - value
	$FSM.change_state(6)
