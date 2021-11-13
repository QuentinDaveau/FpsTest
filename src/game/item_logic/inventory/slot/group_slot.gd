extends Slot
class_name GroupSlot


var _accepted_group: int


func _init(accepted_group: int, max_amount: int).(max_amount) -> void:
	_accepted_group = accepted_group



func can_receive(item: ItemContainer) -> bool:
	return item.get_group() == _accepted_group and not is_full() and (item.get_type() == _item.get_type() if _item else true)
