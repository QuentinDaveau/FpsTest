extends ArmsBehaviour


"""
Makes the weapon follow the camera forward
"""


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_camera_forward_updated", "_on_forward_updated")



func _on_forward_updated(forward: Vector3) -> void:
	var x_axis := Vector3.UP.cross(forward).normalized()
	transform.basis = Basis(x_axis, forward.cross(x_axis), forward)
