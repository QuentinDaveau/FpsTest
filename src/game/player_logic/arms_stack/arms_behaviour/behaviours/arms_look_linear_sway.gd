extends ArmsBehaviour


"""
Makes the weapon rotation sway when the player moves his view around
"""

var _previous_forward: Basis
var _current_forward: Basis


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_camera_forward_updated", "_on_forward_updated")


# TEMP: Will have to set parameters in parameters file
func _process(delta: float) -> void:
	var delta_basis := (_current_forward * _previous_forward.transposed()).get_euler() / 25.0
	var target_translation := Vector3(-delta_basis.y, delta_basis.x + delta_basis.z, 0.0)
	transform.origin = transform.origin.linear_interpolate(target_translation, 30.0 * delta)
	_previous_forward = _current_forward



func _on_forward_updated(forward: Vector3) -> void:
	var x_axis := Vector3.UP.cross(forward).normalized()
	_current_forward = Basis(x_axis, forward.cross(x_axis).normalized(), forward.normalized())



