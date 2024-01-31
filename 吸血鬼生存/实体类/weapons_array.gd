class_name WeaponsArray

const BIG_SWORD = preload("res://吸血鬼生存/资源/武器/big_sword.tres")
const DOUBLE_HEADED_AXE = preload("res://吸血鬼生存/资源/武器/double_headed_axe.tres")
const HAMMER = preload("res://吸血鬼生存/资源/武器/hammer.tres")
const HEAD_CONE_SWORD = preload("res://吸血鬼生存/资源/武器/head_cone_sword.tres")
const ICE_STICKS = preload("res://吸血鬼生存/资源/武器/ice_sticks.tres")
const IRON_RODS = preload("res://吸血鬼生存/资源/武器/iron_rods.tres")
const MAGIC_WAND = preload("res://吸血鬼生存/资源/武器/magic_wand.tres")
const SINGLE_HEADED_AXE = preload("res://吸血鬼生存/资源/武器/single_headed_axe.tres")
const SMALL_SWORD = preload("res://吸血鬼生存/资源/武器/small_sword.tres")
const SWORD = preload("res://吸血鬼生存/资源/武器/sword.tres")
const WOODEN_SWORD = preload("res://吸血鬼生存/资源/武器/wooden_sword.tres")

const BIG_SWORD_SCENE = preload("res://吸血鬼生存/资源/武器/big_sword.tscn")
const DOUBLE_HEADED_AXE_SCENE = preload("res://吸血鬼生存/资源/武器/double_headed_axe.tscn")
const HAMMER_SCENE = preload("res://吸血鬼生存/资源/武器/hammer.tscn")
const HEAD_CONE_SWORD_SCENE = preload("res://吸血鬼生存/资源/武器/head_cone_sword.tscn")
const ICE_STICKS_SCENE = preload("res://吸血鬼生存/资源/武器/ice_sticks.tscn")
const IRON_RODS_SCENE = preload("res://吸血鬼生存/资源/武器/iron_rods.tscn")
const MAGIC_WAND_SCENE = preload("res://吸血鬼生存/资源/武器/magic_wand.tscn")
const SINGLE_HEADED_AXE_SCENE = preload("res://吸血鬼生存/资源/武器/single_headed_axe.tscn")
const SMALL_SWORD_SCENE = preload("res://吸血鬼生存/资源/武器/small_sword.tscn")
const SWORD_SCENE = preload("res://吸血鬼生存/资源/武器/sword.tscn")
const WOODEN_SWORD_SCENE = preload("res://吸血鬼生存/资源/武器/wooden_sword.tscn")

var weapons_atlas_array:Array = [BIG_SWORD,DOUBLE_HEADED_AXE,HAMMER,HEAD_CONE_SWORD,ICE_STICKS,\
								IRON_RODS,MAGIC_WAND,SINGLE_HEADED_AXE,SMALL_SWORD,SWORD,WOODEN_SWORD]
								
var weapons_scene_array:Array = [BIG_SWORD_SCENE,DOUBLE_HEADED_AXE_SCENE,HAMMER_SCENE,HEAD_CONE_SWORD_SCENE\
								,ICE_STICKS_SCENE,IRON_RODS_SCENE,MAGIC_WAND_SCENE,SINGLE_HEADED_AXE_SCENE\
								,SMALL_SWORD_SCENE,SWORD_SCENE,WOODEN_SWORD_SCENE]
								
var weapons_info_array:Array = ["1","2","3","4","5","6","7","8","9","10","11"]

var weapons_array:Array = []

func _init() -> void:
	for i in range(weapons_atlas_array.size()):
		var weapons = Weapons.new()
		weapons.atlas = weapons_atlas_array[i]
		weapons.info = weapons_info_array[i]
		weapons_array.push_back(weapons)
		
func size()->int:
	return weapons_array.size()
		
func get_random_weapons()->Weapons:
	return weapons_array.pick_random()
	
func get_weapons(index:int)->Weapons:
	return weapons_array[index]

func get_weapons_packed(index:int)->PackedScene:
	
	return weapons_scene_array[index]
