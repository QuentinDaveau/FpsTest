extends Object
class_name EquipableHandler


"""
Class dedicated to handle the equipables contained in its owner inventory.
"""

signal unequipped(equipable)
signal equipped(equipable)



var _source_inventory: InventoryInterface
var _current_equipable: Equipable



func _init(source_inventory: InventoryInterface) -> void:
	_source_inventory = source_inventory


# TEMP: Will be Equipable group, and group will be replaced by tags
func get_all_owned_equipables() -> Array:
	return _source_inventory.get_inventory().get_all_items_group(ItemDB.GROUP.WEAPON)



# TEMP: Should wait for previous equipable to be unequipped (animation finished
# and stuff) before equipping new equipable
func equip(equipable: Equipable, replace_current: bool = true) -> bool:
	if replace_current or _current_equipable == null:
		if _current_equipable:
			_current_equipable.unequip()
			emit_signal("unequipped", _current_equipable)
		_current_equipable = equipable
		_current_equipable.equip(_source_inventory)
		emit_signal("equipped", _current_equipable)
		return true
	return false



func set_use(usage: int, use: bool = true) -> bool:
	if not _current_equipable or not _current_equipable.can_use(usage):
		return false
	if use:
		_current_equipable.use(usage)
	else:
		_current_equipable.stop_use(usage)
	return true



func is_using(usage: int) -> bool:
	if not _current_equipable or _current_equipable.get_current_usage() != usage:
		return false
	return true



func has_equipable() -> bool:
	return _current_equipable != null
