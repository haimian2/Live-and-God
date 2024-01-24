extends Node

signal experience_collected(num:int)
signal ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)
signal vampires_survived_character_selection(sprite:AtlasTexture,text:String)

func emit_experience_collected(num:int)->void:
	experience_collected.emit(num)

func emit_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	ability_upgrade_added.emit(upgrade,current_upgrades)

func emit_vampires_survived_character_selection(sprite:AtlasTexture,text:String):
	vampires_survived_character_selection.emit(sprite,text)
