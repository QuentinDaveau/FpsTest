extends Object
class_name Inventory

"""
Class dedicated to store items (within Slot) and to manage the creation, addition
and removal of thoses
"""


signal added_slot(slot)
signal removed_slot(slot)


# TODO: Possibility to change the array to dict of array, can be changed if needed (but adds extra complexity)
var _slots: Array = []
var _counter: int = -1



func receive_item(item: ItemContainer) -> ItemContainer:
	var own_slot := _get_free_slot_for(item.get_type())
	if not own_slot:
		return item
	var leftover := own_slot.add(item)
	return _handle_leftover(leftover)



func push_specific_item(receiver_inventory: Inventory, target_slot_uid: int, amount: int = -1) -> void:
	var target_slot = _find_slot_from_uid(target_slot_uid)
	if not target_slot:
		return
	_handle_returned_item(receiver_inventory.receive_item(target_slot.take(amount)))



func push_type_item(receiver_inventory: Inventory, target_slot_type: int = -1, amount: int = -1) -> void:
	if not _slots:
		return
	var target_slot = _slots[0] if target_slot_type == -1 else _find_slot_from_type(target_slot_type)
	if not target_slot:
		return
	_handle_returned_item(receiver_inventory.receive_item(target_slot.take(amount)))



func _get_free_slot_for(item_type: int) -> Slot:
	for own_slot in _slots:
		if own_slot.can_receive(item_type):
			return own_slot
	return _handle_no_free_slot(item_type)



func _find_slot_from_type(item_type: int) -> Slot:
	for slot in _slots:
		if slot.has_item_type(item_type):
			return slot
	return null



func _find_slot_from_uid(slot_uid: int) -> Slot:
	for slot in _slots:
		if slot.get_uid() == slot_uid:
			return slot
	return null



func _add_slot(slot: Slot) -> void:
	_slots.append(slot)
	slot.connect("emptied", self, "_on_slot_emptied", [slot])



# To be overridden
func _handle_no_free_slot(item_type: int) -> Slot:
	return null



# To be overridden
func _handle_leftover(leftover: ItemContainer) -> ItemContainer:
	return leftover



# Can be overridden
func _handle_returned_item(returned: ItemContainer) -> void:
	receive_item(returned)



# TODO: See if we delete slots or not
func _on_slot_empty(slot: Slot) -> void:
	pass

