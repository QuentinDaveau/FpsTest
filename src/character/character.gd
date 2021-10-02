extends KinematicBody
class_name Character


var _controller: CharacterController



func register_controller(controller: CharacterController) -> void:
	_controller = controller



func get_controller() -> CharacterController:
	return _controller
