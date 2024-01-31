class_name VampireSurvivalCharacterArray

const BARBARIAN = preload("res://吸血鬼生存/资源/人物/barbarian.tres")
const BEAR_WARRIOR = preload("res://吸血鬼生存/资源/人物/bear_warrior.tres")
const CRAFTSMAN = preload("res://吸血鬼生存/资源/人物/craftsman.tres")
const ENCHANTER = preload("res://吸血鬼生存/资源/人物/enchanter.tres")
const FULLY_EQUIPPED_WITH_KNIGHTS = preload("res://吸血鬼生存/资源/人物/fully_equipped_with_knights.tres")
const GRANDMA = preload("res://吸血鬼生存/资源/人物/grandma.tres")
const NORMAL_PEOPLE = preload("res://吸血鬼生存/资源/人物/normal_people.tres")
const ORDINARY_KNIGHTS = preload("res://吸血鬼生存/资源/人物/ordinary_knights.tres")
const PRINCESS = preload("res://吸血鬼生存/资源/人物/princess.tres")

var character_atlas_array:Array = [BARBARIAN,BEAR_WARRIOR,CRAFTSMAN,ENCHANTER,FULLY_EQUIPPED_WITH_KNIGHTS,\
								GRANDMA,NORMAL_PEOPLE,ORDINARY_KNIGHTS,PRINCESS]
var character_info_array:Array = ["1","2","3","4","5","6","7","8","9"]
var character_name_array:Array = ["野蛮人","熊战士","工匠","魔法师","重装骑士","老奶奶","普通人","轻装骑士","公主"]

var character_array:Array = []

func _init() -> void:
	for i in range(0,character_atlas_array.size() - 1):
		var vampire_survival_character = VampireSurvivalCharacter.new()
		vampire_survival_character.texture = character_atlas_array[i]
		vampire_survival_character.info = character_info_array[i]
		vampire_survival_character.name = character_name_array[i]
		character_array.push_back(vampire_survival_character)
		
func size()->int:
	return character_array.size()
		
func get_random_character()->VampireSurvivalCharacter:
	return character_array.pick_random()
	
func get_character(index:int)->VampireSurvivalCharacter:
	return character_array[index]
