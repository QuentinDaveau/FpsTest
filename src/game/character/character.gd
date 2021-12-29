extends KinematicBody
class_name Character



# TEMP for debug
signal inventory_updated(inventory)


var _controller: CharacterController
var _inventory: InventoryInterface
var _equipable_handler: EquipableHandler


# TODO: See if the registering could be implemented in the _init itself
func register_controller(controller: CharacterController) -> void:
	_controller = controller



func register_inventory(inventory: InventoryInterface) -> void:
	_inventory = inventory
	_inventory.connect("inventory_updated", self, "_on_inventory_updated")



func register_equipable_handler(equipable_handler: EquipableHandler) -> void:
	_equipable_handler = equipable_handler



func get_controller() -> CharacterController:
	return _controller



func get_inventory() -> InventoryInterface:
	return _inventory



func get_equipable_handler() -> EquipableHandler:
	return _equipable_handler


# TEMP: debug
func _on_inventory_updated() -> void:
	emit_signal("inventory_updated", _inventory.get_inventory())
