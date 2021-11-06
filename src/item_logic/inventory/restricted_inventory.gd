extends Inventory
class_name RestrictedInventory

"""
Inventory that has restrictions on certain types of slots.
Can contain extra slots (of unlocked type), or not.
"""


var _restrictions: Array
var _allow_unrestricted_slots: bool



func _init(slots_restrictions: Array, allow_unrestricted_slots: bool = false) -> void:
	_restrictions = slots_restrictions
	_allow_unrestricted_slots = allow_unrestricted_slots



func receive_item(slot: Slot, amount: int = -1, create_on_leftover: bool = true) -> int:
	return 0



func push_specific_item(receiver_inventory: Inventory, target_slot_uid: int, amount: int = -1) -> void:
	pass



func push_type_item(receiver_inventory: Inventory, target_slot_type: int = -1, amount: int = -1) -> void:
	pass



func _copy_slot(slot: Slot, add_to_self: bool = false) -> Slot:
	return ._copy_slot(slot, add_to_self)



func _get_restriction(slot: Slot) -> Item.SlotRestriction:
	for restriction in _restrictions:
		if restriction.is_group:
			if restriction.type_or_group == slot.get_group():
				return restriction
		elif restriction.type_or_group == slot.get_type():
			return restriction
	return null

