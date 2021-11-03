extends Slot
class_name InstanceSlot


var _item: Object


func _init(type: int, uid: int, is_unique: bool, item: Object).(type, uid, 1, 1, is_unique) -> void:
	_item = item



func get_item():
	return _item
