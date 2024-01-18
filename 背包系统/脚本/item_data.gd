extends Resource
class_name ItemData

@export var name:String = ""
@export_multiline var description:String = ""
@export var stackable:bool = false
@export var texture:AtlasTexture = null

@export var type = ItemType.Nothing
@export var add_health:int = 0
@export var add_magic:int = 0
@export var add_damage:int = 0
@export var add_defense:int = 0
@export var add_energy:int = 0

enum ItemType{
	Nothing,
	Attack,
	Defense,
	Head,
	Chest,
	Leg,
	Shoe,
	Ring,
	Consumables,
}
