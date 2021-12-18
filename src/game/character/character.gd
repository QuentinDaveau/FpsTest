extends KinematicBody
class_name Character



# TEMP for debug
signal inventory_updated(inventory)


var _controller: CharacterController
var _inventory: Inventory


# TODO: See if the registering could be implemented in the _init itself
func register_controller(controller: CharacterController) -> void:
	_controller = controller



func register_inventory(inventory: Inventory) -> void:
	_inventory = inventory
	_inventory.connect("updated", self, "_on_inventory_updated")



func get_controller() -> CharacterController:
	return _controller



func get_inventory() -> Inventory:
	return _inventory



func _on_inventory_updated() -> void:
	emit_signal("inventory_updated", _inventory)
