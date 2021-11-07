extends KinematicBody
class_name Character


var _controller: CharacterController
var _inventory: Inventory


# TODO: See if the registering could be implemented in the _init itself
func register_controller(controller: CharacterController) -> void:
	_controller = controller



func register_inventory(inventory: Inventory) -> void:
	_inventory = inventory



func get_controller() -> CharacterController:
	return _controller



func get_inventory() -> Inventory:
	return _inventory


