extends UpperBodyBehaviour


"""
Makes the upper body follow the camera forward with a wiggle room. 
Does not take camera effects into account (shake, recoil...)
"""

# TODO: Add wiggle room and take into account movement (rotation between head and legs)

func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_camera_forward_updated", "_on_forward_updated")



func _on_forward_updated(forward: Vector3) -> void:
	forward.y = 0.0
	transform.basis = Basis(Vector3.UP.cross(forward).normalized(), Vector3.UP, forward)
