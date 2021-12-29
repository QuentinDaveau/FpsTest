extends Object
class_name InventoryInterface


"""
Class dedicated to add a logic layer between the inventory and the components
that will access it. Is to be extended to add specific behaviours depending
on the owner of the inventory (character, pickable...)
"""

signal inventory_updated()


var _inventory: Inventory



func _init(inventory: Inventory) -> void:
	_inventory = inventory
	_inventory.connect("updated", self, "_on_inventory_updated")



func get_inventory() -> Inventory:
	return _inventory



#To override
func transfer_item(receiver_inventory: Inventory, type: int = -1, amount: int = -1) -> Inventory.TransactionResult:
	# do check if necessary before or/and after transfer
	return _do_transfer(receiver_inventory, type, amount)



func receive_item(source_inventory: Inventory, type: int = -1, amount: int = -1) -> Inventory.TransactionResult:
	# do check if necessary before or/and after transfer
	return _do_receive(source_inventory, type, amount)



func _do_transfer(receiver_inventory: Inventory, type: int, amount: int) -> Inventory.TransactionResult:
	return _inventory.push_type_item(receiver_inventory, type, amount)



func _do_receive(source_inventory: Inventory, type: int, amount: int) -> Inventory.TransactionResult:
	return source_inventory.push_type_item(_inventory, type, amount)



func _on_inventory_updated() -> void:
	emit_signal("inventory_updated")

