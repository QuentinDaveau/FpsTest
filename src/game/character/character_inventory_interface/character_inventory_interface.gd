extends InventoryInterface
class_name CharacterInventoryInterface


"""
Class dedicated to do the interface between the character's inventory and
any other component (to centralize character inventory logic)
"""

# TEMP: May not be necessary, and restricts the systemic nature of the code ?

signal item_transferred(type, amount, amount_contained)
signal item_received(type, amount, amount_contained)



func _init(character_inventory: Inventory).(character_inventory) -> void:
	pass



func transfer_item(receiver_inventory: Inventory, type: int = -1, amount: int = -1) -> Inventory.TransactionResult:
	var result := _do_transfer(receiver_inventory, type, amount)
	if result.transacted_amount > 0:
		emit_signal("item_transferred", type, result.transacted_amount, _inventory.get_type_item_amount(type))
	return result



func receive_item(source_inventory: Inventory, type: int = -1, amount: int = -1) -> Inventory.TransactionResult:
	var result := _do_receive(source_inventory, type, amount)
	if result.transacted_amount > 0:
		emit_signal("item_received", type, result.transacted_amount, _inventory.get_type_item_amount(type))
	return result
