extends ArmsBehaviour


"""
Makes the weapon rotation sway when the player moves his view around
"""


var _previous_position: Vector3


# TEMP: Will have to set parameters in parameters file
func _process(delta: float) -> void:
	var velocity := global_transform.origin - _previous_position
	var target_translation := -velocity / 5.0
	transform.origin = transform.origin.linear_interpolate(target_translation, 20.0 * delta)
	_previous_position = global_transform.origin
