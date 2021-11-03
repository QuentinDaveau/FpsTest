extends Node
class_name Item

"""
Class dedicated to manage and create slots and items that can be contained in
said slots
"""


var _counter: int = -1



func _init() -> void:
	Service.register(self, Service.TYPE.ITEM)



func generate(item_type: int, amount: int = -1) -> Slot:
	if not ItemDB.ID.has(item_type):
		return null
	var properties: ItemDB.ItemProperties = ItemDB.ITEM_DATA.get(item_type)
	return _create_slot(item_type, properties, _get_instance(properties.class_path), amount)



func copy_slot(slot: Slot) -> Slot:
	var item_type := slot.get_type()
	if not ItemDB.ID.has(item_type):
		return null
	var properties: ItemDB.ItemProperties = ItemDB.ITEM_DATA.get(item_type)
	return _create_slot(item_type, properties, slot.get_item(), 0)



func _generate_uid() -> int:
	_counter += 1
	return _counter



func _create_slot(item_type: int, properties: ItemDB.ItemProperties, instance: Object, uid: int, amount: int = -1) -> Slot:
	if properties.is_instance:
		return InstanceSlot.new(item_type, _generate_uid(), properties.is_unique, instance)
	else:
		return DataSlot.new(item_type, _generate_uid(), properties.amount if amount == -1 else amount, properties.max_amount, properties.is_unique, instance)



func _get_instance(var load_path: String) -> Object:
	return load(load_path).instance()

