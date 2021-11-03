extends Object
class_name ItemDB

"""
Data class dedicated to store the items data
"""


enum ID {
	RIFLE,
	SHOTGUN,
	SNIPER,
	PISTOL
}



var ITEM_DATA := {
	ID.RIFLE: ItemProperties.new(1, true, true, ""),
	ID.SHOTGUN: ItemProperties.new(1, true, true, ""),
	ID.SNIPER: ItemProperties.new(1, true, true, ""),
	ID.PISTOL: ItemProperties.new(1, true, true, ""),
}








class ItemProperties:
	
	var max_amount: int
	var is_unique: bool
	var is_instance: bool
	var class_path: String
	
	func _init(max_amount: int, is_unique: bool, is_instance: bool, class_path: String) -> void:
		self.class_path = class_path
		self.is_instance = is_instance
		self.is_unique = is_unique
		self.max_amount = max_amount if not is_instance else 1
