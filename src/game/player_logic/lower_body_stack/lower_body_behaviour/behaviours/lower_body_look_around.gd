extends LowerBodyBehaviour


"""
Makes the lower body follow the camera forward with a wiggle room. 
Does not take camera effects into account (shake, recoil...)
"""

# TODO: Add wiggle room and take into account movement (rotation between head and legs)
# TODO: Make it a generic behaviour

var _can_wiggle: bool = true
var _camera_forward: Vector3



func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_camera_forward_updated", "_on_forward_updated")
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")



# TEMP: Wiggle room parameter will be set in parameters file
func _on_forward_updated(forward: Vector3) -> void:
	forward.y = 0.0
	forward = forward.normalized()
	_camera_forward = forward
	var target_forward := Basis(Vector3.UP.cross(forward).normalized(), Vector3.UP, forward)
	if _can_wiggle:
		var wiggle_room := 0.6
		var angle_rads := sin(wiggle_room)
		var clamped_forward := Basis(forward.cross(transform.basis.z).normalized(), clamp(forward.angle_to(transform.basis.z), 0.0, angle_rads))
		target_forward = clamped_forward * target_forward
	transform.basis = target_forward



func _on_player_state_changed(new_state: String) -> void:
	_can_wiggle = new_state == "Idle"
	if not _can_wiggle:
		_on_forward_updated(_camera_forward)

