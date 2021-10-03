extends Character
class_name Player

"""
Player class. Serves as a container its different components
"""

export(Vector3) var head_position := Vector3(0.0, 1.35, 0.0)



func _init() -> void:
	register_controller(PlayerController.new(self))



func _physics_process(delta: float) -> void:
	_controller.update(delta)
