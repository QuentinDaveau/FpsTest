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


var _type: int
var _amount: int
var _max_amount: int
var _unique: bool
var _uid: int



func _init(type: int, uid: int, amount: int, max_amount: int, unique: bool = false) -> void:
	assert(amount <= max_amount)
	_type = type
	_uid = uid
	_amount = amount
	_max_amount = max_amount
	_unique = unique



func add(quantity: int) -> int:
	var new_amount = _amount + quantity
	var leftover = 0
	if new_amount > _max_amount:
		leftover = new_amount - _max_amount
		new_amount = _max_amount
		emit_signal("filled")
	_amount = new_amount
	emit_signal("added_amount", quantity - leftover, _amount)
	return leftover



func take(quantity: int) -> int:
	var new_amount = _amount - quantity
	var leftover = 0
	if new_amount <= 0:
		leftover = - new_amount
		new_amount = 0
		emit_signal("emptied")
	_amount = new_amount
	emit_signal("removed_amount", quantity - leftover, _amount)
	return quantity - leftover



func is_unique() -> bool:
	return _unique



func get_max_amount() -> int:
	return _max_amount



func get_amount() -> int:
	return _amount



func is_full() -> bool:
	return _amount == _max_amount



func get_type() -> int:
	return _type



func get_uid() -> int:
	return _uid



# To be overriden
func get_item():
	pass
