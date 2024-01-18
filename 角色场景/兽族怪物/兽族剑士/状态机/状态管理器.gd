extends Node
class_name State_Manager

@onready var states:Array = get_children()
@onready var curState = $RightRun

func _ready():
	curState.enter()

func _physics_process(delta):
	#print(curState)
	curState.do()

func change_state(id:int)->void:
	curState.exit()
	curState = states[id]
	curState.enter()
