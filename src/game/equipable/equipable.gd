extends Spatial
class_name Equipable

"""
Class that represents an item that can be equipped by a character. handles the
base equiping and un-equiping logic.
The owner inventory can be passed to allow item transfer between the equipable
and owner
"""

signal equip_done()
signal unequip_done()


enum USAGE {
	PRIMARY,
	SECONDARY,
	TERTIARY
}


var _data: EquipableData
var _owner_inventory: Inventory = null



func _init(data: EquipableData) -> void:
	_data = data



# All of those are to be overridden
func equip(owner_inventory: Inventory = null) -> void:
	_owner_inventory = owner_inventory
	emit_signal("equip_done")



func unequip() -> void:
	_owner_inventory = null
	emit_signal("unequip_done")



func use(usage: int) -> void:
	if not can_use(usage): return



func stop_use(usage: int) -> void:
	if not can_use(usage): return



func can_use(usage: int) -> bool:
	return _data.allowed_usages & usage

