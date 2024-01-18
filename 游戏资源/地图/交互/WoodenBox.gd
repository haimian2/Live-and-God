extends Node2D

signal process_player_interact(player:Object)

const BIG_COPPER = preload("res://游戏资源/地图/交互/big_copper.tscn")
const BIG_GOLD_COIN = preload("res://游戏资源/地图/交互/big_gold_coin.tscn")
const GOLDCOIN = preload("res://游戏资源/地图/交互/goldcoin.tscn")
const COPPER = preload("res://游戏资源/地图/交互/copper.tscn")
const WOODENSWORD = preload("res://背包系统/场景/woodensword.tscn")

var coins:Array = [BIG_COPPER,BIG_GOLD_COIN,GOLDCOIN,COPPER]

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	process_player_interact.connect(process_open)

func process_open(player:Object):
	animation_player.play("打开箱子")

func create_coin():
	var i = randi() % 4
	var coin = coins[i].instantiate()
	coin.position = position
	var woddensword = WOODENSWORD.instantiate()
	woddensword.position = position
	if owner:
		owner.get_node("Collection").add_child(coin)
		owner.get_node("Collection").add_child(woddensword)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_E_KEY(self,true)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.process_E_KEY(self,false)
