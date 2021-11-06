extends Object
class_name ItemContainer

"""
Simple cointainer class which acts as a wrapper to be handled in inventories. Is
not meant to be directly accessed, but to identify the item and its quantity in
inventory slots
"""


var _group: int
var _type: int
var _amount: int
var _item: Object


func _init(group: int, type: int, amount: int, item: Object) -> void:
	assert(amount > 0, "ItemContainer amount has to be over 0 otherwise the container cannot exist (contains nothing)!")
	_group = group
	_type = type
	_amount = amount
	_item = item



func get_amount() -> int:
	return _amount



func set_amount(new_amount: int) -> void:
	assert(new_amount > 0)
	_amount = new_amount



func get_type() -> int:
	return _type



func get_group() -> int:
	return _group

