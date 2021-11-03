extends Slot
class_name DataSlot


var _item: Object


func _init(type: int, uid: int, amount: int, max_amount: int, is_unique: bool, item: Object).(type, uid, amount, max_amount, is_unique) -> void:
	_item = item



func get_item():
	return _item

