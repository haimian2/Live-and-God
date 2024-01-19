extends Node

signal experience_collected(num:int)
signal ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)

func emit_experience_collected(num:int)->void:
	experience_collected.emit(num)

func emit_ability_upgrade_added(upgrade:AbilityUpgrade,current_upgrades:Dictionary)->void:
	ability_upgrade_added.emit(upgrade,current_upgrades)
