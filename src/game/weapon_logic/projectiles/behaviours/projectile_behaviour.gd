extends Resource
class_name ProjectileBehaviour
tool


"""
Class dedicated to store data and process dedicated projectile behaviour
"""


var _owner_node: Spatial



func spawn(owner_node: Spatial) -> void:
	_owner_node = owner_node
	_handle_spawn()


func process(delta: float) -> void:
	_handle_process(delta)


# To be overridden
func _handle_spawn() -> void:
	pass


# To be overridden
func _handle_process(delta: float) -> void:
	pass



