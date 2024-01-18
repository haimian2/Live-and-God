extends Node

@onready var states:Array = get_children()
@onready var curState = $IDLE

func _ready():
	curState.enter()

func _physics_process(delta):
	#print(curState)
	curState.do()

func change_state(id:int)->void:
	curState.exit()
	curState = states[id]
	curState.enter()
