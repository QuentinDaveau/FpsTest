extends Object
class_name Inventory

"""
Class dedicated to store items (within Slot) and to manage the creation, addition
and removal of thoses
"""

# TODO: Possibility to change the array to dict of array, can be changed if needed (but adds extra complexity)
var _slots: Array = []



func receive_item(slot: Slot, amount: int = -1) -> int:
	var own_slot := _get_free_slot(slot)
	if not own_slot:
		return slot.get_amount()
	var leftover := _transfer_between_slots(slot, own_slot, amount)
	if leftover:
		if own_slot.is_unique():
			return leftover
		else:
			var new_slot := _copy_slot(slot)
			new_slot.add(leftover)
			return receive_item(new_slot)
	else:
		return 0



func push_specific_item(receiver_inventory: Inventory, target_slot_uid: int, amount: int = -1) -> void:
	var target_slot = _find_slot_from_uid(target_slot_uid)
	if not target_slot:
		return
	receiver_inventory.receive_item(target_slot, amount)



func push_type_item(receiver_inventory: Inventory, target_slot_type: int = -1, amount: int = -1) -> void:
	if not _slots:
		return
	var target_slot = _slots[0] if target_slot_type == -1 else _find_slot_from_type(target_slot_type)
	if not target_slot:
		return
	receiver_inventory.receive_item(target_slot, amount)



func _transfer_between_slots(from_slot: Slot, to_slot: Slot, amount: int = -1) -> int:
	var amount_to_take := from_slot.get_amount() if amount == -1 else amount
	var leftovers := to_slot.add(amount_to_take)
	from_slot.take(amount_to_take - leftovers)
	return leftovers



func _get_free_slot(slot: Slot) -> Slot:
	for own_slot in _slots:
		if own_slot.get_type() == slot.get_type():
			if own_slot.is_full():
				if own_slot.is_unique():
					return null
			else:
				return own_slot
	return _copy_slot(slot, true)



func _find_slot_from_type(slot_type: int) -> Slot:
	for slot in _slots:
		if slot.get_type() == slot_type:
			return slot
	return null



func _find_slot_from_uid(slot_uid: int) -> Slot:
	for slot in _slots:
		if slot.get_uid() == slot_uid:
			return slot
	return null



func _copy_slot(slot: Slot, add_to_self: bool = false) -> Slot:
	var new_slot: Slot = Service.fetch(Service.TYPE.ITEM).copy_slot(slot)
	if add_to_self:
		_add_slot(new_slot)
	return new_slot



func _add_slot(slot: Slot) -> void:
	_slots.append(slot)

