extends CharacterController
class_name PlayerController

"""
Class dedicated to control the player movements. Serves as an interface between
the player and the elements controlling it.
"""

var _camera_forward: Vector3 = Vector3.ZERO
var _relative_direction: Vector2 = Vector2.ZERO
var _relative_velocity: Vector3 = Vector3.ZERO
var _move_speed: float = 0.0



func _init(target_character: KinematicBody).(target_character) -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_camera_forward_updated", "_on_camera_forward_updated")



func move(relative_direction: Vector2, move_speed: float) -> void:
	_move_speed = move_speed
	_relative_direction = relative_direction
	_relative_velocity = _get_forward_velocity()



func update(delta: float) -> void:
	var new_velocity = _residual_velocity
	# TEMP: lerp value will be defined in an acceleration parameter in a "parameters" file
	new_velocity.x = lerp(new_velocity.x, _relative_velocity.x, 0.9)
	new_velocity.z = lerp(new_velocity.z, _relative_velocity.z, 0.9)
	new_velocity = _add_gravity_to(new_velocity, delta)
	apply_motion(new_velocity)
	.update(delta)



func _get_forward_velocity() -> Vector3:
	var relative_rotation = -Vector2(_camera_forward.z, _camera_forward.x).angle()
	var v2_velocity = _relative_direction.rotated(relative_rotation).normalized()
	return Vector3(v2_velocity.x, 0.0, v2_velocity.y) * _move_speed



# TEMP: Arbitrary gravity value. It will be then set in a "parameters" file
func _add_gravity_to(velocity_vector: Vector3, delta: float) -> Vector3:
	return velocity_vector + Vector3(0.0, -9.8, 0.0) * delta



func _on_camera_forward_updated(camera_forward: Vector3) -> void:
	_camera_forward = camera_forward
	if _relative_direction:
		_relative_velocity = _get_forward_velocity()
