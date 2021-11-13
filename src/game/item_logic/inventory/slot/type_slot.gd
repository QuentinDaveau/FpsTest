extends Slot
class_name TypeSlot


var _accepted_type: int


func _init(accepted_type: int, max_amount: int).(max_amount) -> void:
	_accepted_type = accepted_type



func can_receive(item: ItemContainer) -> bool:
	return item.get_type() == _accepted_type and not is_full()
