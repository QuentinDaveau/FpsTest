extends Object
class_name Slot

"""
Generic Class dedicated to count items. Is used as a wrapper in the inventory to
handle the logic when picked or dropped, and can be derived to handle different
logics (creation of specific object...)
"""

signal added_amount(added, new_amount)
signal removed_amount(removed, new_amount)
signal emptied()
signal filled()



var _uid: int = -1
var _max_amount: int
var _item: ItemContainer



func _init(max_amount: int) -> void:
	assert(max_amount > 0, "An inventory slot has to be able to contain at least one item!")
	_max_amount = max_amount



# TODO: try to clean this mess
func add(new_item: ItemContainer) -> ItemContainer:
	if not can_receive(new_item):
		return new_item
	var quantity_to_add := new_item.get_amount()
	var leftover := 0
	var new_amount := quantity_to_add + (_item.get_amount() if has_item() else 0)
	if new_amount > _max_amount:
		leftover = new_amount - _max_amount
		new_amount = _max_amount
		emit_signal("filled")
	var old_item := _set_or_swap_item(new_item, new_amount)
	emit_signal("added_amount", quantity_to_add - leftover, new_amount)
	if leftover:
		if not old_item:
			return _create_item(new_item.get_type(), leftover)
		else:
			old_item.set_amount(leftover)
			return old_item
	return null


# TODO: try to clean this mess
func take(quantity: int) -> ItemContainer:
	assert(quantity > 0 and has_item())
	var new_amount := _item.get_amount() - quantity
	var leftover := 0
	if new_amount <= 0:
		leftover = - new_amount
		new_amount = 0
		emit_signal("emptied")
	emit_signal("removed_amount", quantity - leftover, new_amount)
	if new_amount > 0:
		var old_item = _item
		old_item.set_amount(quantity)
		_item = _create_item(old_item.get_type(), new_amount)
		return old_item
	else:
		var item = _item
		_item = null
		return item



func set_uid(uid: int) -> void:
	assert(_uid == -1 and uid >= 0)
	_uid = uid



func get_uid() -> int:
	return _uid



func get_max_amount() -> int:
	return _max_amount



func get_amount() -> int:
	return _item.get_amount() if has_item() else 0



func is_full() -> bool:
	return _item.get_amount() == _max_amount if has_item() else false



func can_receive(item: ItemContainer) -> bool:
	return not has_item() or (_item.get_type() == item.get_type() and not is_full())



func has_item_type(item_type: int) -> bool:
	return has_item() and item_type == _item.get_type()



func has_item() -> bool:
	return _item != null and not _item.is_queued_for_deletion()



func get_item():
	return _item







func _set_or_swap_item(new_item: ItemContainer, amount: int) -> ItemContainer:
	var old_item := _item
	if not has_item() or _item != new_item:
		_item = new_item
	_item.set_amount(amount)
	return old_item



func _create_item(item_type: int, amount: int) -> ItemContainer:
	return Service.fetch(Service.TYPE.ITEM).generate(item_type, amount)
