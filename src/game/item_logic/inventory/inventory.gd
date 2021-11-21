extends Object
class_name Inventory

"""
Class dedicated to store items (within Slot) and to manage transaction with 
other inventories.
"""


signal added_slot(slot)
signal removed_slot(slot)
signal emptied()
signal updated()


# TODO: Possibility to change the array to dict of array, can be changed if needed (but adds extra complexity)
var _slots: Array
var _uid_counter: int = -1



func _init(starting_slots: Array) -> void:
	for slot in starting_slots:
		_add_slot(slot)



func receive_item(item: ItemContainer) -> ItemContainer:
	if not item:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.INFO, self, "Received null item !")
		return null
	var own_slot := _get_free_slot_for(item)
	if not own_slot:
		return item
	var leftover := own_slot.add(item)
	var handled_leftovers := _handle_leftover(leftover)
	emit_signal("updated")
	return handled_leftovers



func push_specific_item(receiver_inventory: Inventory, target_slot_uid: int, amount: int = -1) -> void:
	var target_slot = _find_slot_from_uid(target_slot_uid)
	if not target_slot:
		return
	_handle_returned_item(receiver_inventory.receive_item(target_slot.take(amount)))
	emit_signal("updated")



func push_type_item(receiver_inventory: Inventory, target_slot_type: int = -1, amount: int = -1) -> void:
	if not _slots:
		return
	var target_slot = _slots[0] if target_slot_type == -1 else _find_slot_from_type(target_slot_type)
	if not target_slot:
		return
	_handle_returned_item(receiver_inventory.receive_item(target_slot.take(amount if amount != -1 else target_slot.get_amount())))
	emit_signal("updated")


# TODO: Clean those two very similar function (assemble into one ?)
func take_type_item(type: int, amount: int = 1) -> TransactionResult:
	var slot := _find_slot_from_type(type)
	if not slot:
		return TransactionResult.new(TransactionResult.TYPE.TAKE, slot.get_uid, false)
	var taken_items := slot.take(1)
	var result := TransactionResult.new(TransactionResult.TYPE.TAKE, slot.get_uid, true)
	result.extract_secondary_parameters(taken_items)
	return result



func take_group_item(group: int, amount: int = 1) -> TransactionResult:
	var slot := _find_slot_from_group(group)
	if not slot:
		return TransactionResult.new(TransactionResult.TYPE.TAKE, -1, false)
	var taken_items := slot.take(1)
	var result := TransactionResult.new(TransactionResult.TYPE.TAKE, slot.get_uid(), true)
	result.extract_secondary_parameters(taken_items)
	return result



func is_empty() -> bool:
	for slot in _slots:
		if slot.has_item():
			return false
	return true



func _get_free_slot_for(item: ItemContainer) -> Slot:
	for own_slot in _slots:
		if own_slot.can_receive(item):
			return own_slot
	return _handle_no_free_slot(item.get_type())


# TODO: Clean those two very similar function (assemble into one ?)
func _find_slot_from_type(item_type: int) -> Slot:
	for slot in _slots:
		if slot.has_item_type(item_type):
			return slot
	return null



func _find_slot_from_group(item_group: int) -> Slot:
	for slot in _slots:
		if slot.has_item_group(item_group):
			return slot
	return null



func _find_slot_from_uid(slot_uid: int) -> Slot:
	for slot in _slots:
		if slot.get_uid() == slot_uid:
			return slot
	return null



func _add_slot(slot: Slot) -> void:
	slot.set_uid(_generate_uid())
	_slots.append(slot)
	slot.connect("emptied", self, "_on_slot_emptied", [slot])
	emit_signal("added_slot", slot)



func _generate_uid() -> int:
	_uid_counter += 1
	return _uid_counter



# To be overridden
func _handle_no_free_slot(item_type: int) -> Slot:
	return null



# To be overridden
func _handle_leftover(leftover: ItemContainer) -> ItemContainer:
	return receive_item(leftover)



# Can be overridden
func _handle_returned_item(returned: ItemContainer) -> void:
	receive_item(returned)



# TODO: See if we delete slots or not
func _on_slot_emptied(slot: Slot) -> void:
	for slot in _slots:
		if not slot.is_empty():
			return
	emit_signal("emptied")



"""
Class dedicated to be used for transactions with the inventory and non-inventory
classes. Fills the role of the ItemContainer but outside of the inventory
"""
class TransactionResult:
	
	enum TYPE {GIVE, TAKE, FETCH}
	
	var transaction_type: int
	var slot_uid: int
	var item_type: int
	var item_group: int
	var transacted_amount: int
	var item: Object
	var success: bool
	
	
	func _init(transaction_type: int, slot_uid: int, success: bool = true) -> void:
		self.transaction_type = transaction_type
		self.slot_uid = slot_uid
		self.success = success
	
	
	
#	func set_secondary_parameters(item_type: int, item_group: int, transacted_amount: int) -> void:
#		self.item_type = item_type
#		self.item_group = item_group
#		self.transacted_amount = transacted_amount
	
	
	
	func extract_secondary_parameters(item_container: ItemContainer) -> void:
		self.item_type = item_container.get_type()
		self.item_group = item_container.get_group()
		self.transacted_amount = item_container.get_amount()
		self.item = item_container.get_item()
	


