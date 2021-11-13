extends Node
class_name Item

"""
Class dedicated to manage and create slots and items that can be contained in
said slots
"""

signal generated_slot(slot)
signal copied_slot(slot)
signal filled_slot(slot, amount)



func _init() -> void:
	Service.register(self, Service.TYPE.ITEM)



func generate(container_type: int, amount: int = 1) -> ItemContainer:
	if not ItemDB.TYPE.values().has(container_type):
		return null
	var properties: ItemDB.ItemProperties = ItemDB.get_item_data(container_type)
	var container := _create_container(container_type, properties, _get_instance(properties.class_path), amount)
	return container



func _create_container(container_type: int, properties: ItemDB.ItemProperties, instance: Object, amount: int) -> ItemContainer:
	if properties.is_instance:
		return InstanceContainer.new(properties.group, container_type, instance)
	else:
		return DataContainer.new(properties.group, container_type, amount, instance)



func _get_instance(var load_path: String) -> Object:
	return load(load_path).instance()
