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
	NONE,
	PRIMARY,
	SECONDARY,
	TERTIARY
}


var _data: EquipableData
var _owner_inventory: InventoryInterface = null

var _current_usage: int


# Since the Equipable is expected to be a packed scene, we cannot use init (variables
# won't be set), thus we have to use notifications (that apparently won't propagate
# to children, may cause issues in the future ?)
func _notification(notif: int) -> void:
	if not notif == NOTIFICATION_INSTANCED: return
	_set_data(null)


# To override
func _set_data(data: EquipableData) -> void:
	_data = data



# All of those are to be overridden
func equip(owner_inventory: InventoryInterface = null) -> void:
	_owner_inventory = owner_inventory
	emit_signal("equip_done")



func unequip() -> void:
	_owner_inventory = null
	_current_usage = USAGE.NONE
	emit_signal("unequip_done")



func use(usage: int) -> void:
	if not can_use(usage): return
	_current_usage = usage



func stop_use(usage: int) -> void:
	if not can_use(usage): return
	_current_usage = USAGE.NONE



func can_use(usage: int) -> bool:
	return _data.allowed_usages & usage



func get_current_usage() -> int:
	return _current_usage
