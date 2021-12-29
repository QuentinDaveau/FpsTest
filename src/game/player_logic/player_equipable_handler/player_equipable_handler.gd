extends EquipableHandler
class_name PlayerEquipableHandler






func _init(source_inventory: InventoryInterface).(source_inventory) -> void:
	source_inventory.connect("inventory_updated", self, "_on_inventory_updated")



func _on_inventory_updated() -> void:
	if not _current_equipable:
		var equipables: Array = _source_inventory.get_inventory().get_all_items_group(ItemDB.GROUP.WEAPON)
		if equipables.size() > 0:
			equip(equipables[0].item)

