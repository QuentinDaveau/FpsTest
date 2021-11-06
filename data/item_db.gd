extends Object
class_name ItemDB

"""
Data class dedicated to store the items data
"""


enum TYPE {
	RIFLE,
	SHOTGUN,
	SNIPER,
	PISTOL,
	RIFLE_AMMO,
	SHOTGUN_AMMO,
	SNIPER_AMMO,
	PISTOL_AMMO,
}



enum GROUP {
	WEAPON,
	AMMO
}



var ITEM_DATA := {
	TYPE.RIFLE: ItemProperties.new(GROUP.WEAPON, 1, true, ""),
	TYPE.SHOTGUN: ItemProperties.new(GROUP.WEAPON, 1, true, ""),
	TYPE.SNIPER: ItemProperties.new(GROUP.WEAPON, 1, true, ""),
	TYPE.PISTOL: ItemProperties.new(GROUP.WEAPON, 1, true, ""),
	TYPE.RIFLE_AMMO: ItemProperties.new(GROUP.AMMO, 99, false, ""),
	TYPE.SHOTGUN_AMMO: ItemProperties.new(GROUP.AMMO, 99, false, ""),
	TYPE.SNIPER_AMMO: ItemProperties.new(GROUP.AMMO, 99, false, ""),
	TYPE.PISTOL_AMMO: ItemProperties.new(GROUP.AMMO, 99, false, ""),
}








class ItemProperties:
	
	var group: int
	var max_amount: int
	var is_instance: bool
	var class_path: String
	
	func _init(group: int, max_amount: int, is_instance: bool, class_path: String) -> void:
		self.group = group
		self.class_path = class_path
		self.is_instance = is_instance
		self.max_amount = max_amount if not is_instance else 1
