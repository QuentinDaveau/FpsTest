extends Node
class_name CharacterController

"""
Class dedicated to control a character motion. Contains generic functions to
move the target character. The character has to manually call update to get
updated.
"""

# TEMP: _target_character has to be Character. Set to KinematicBody to prevent 
# cyclic dependency error
var _target_character: KinematicBody
var _residual_velocity: Vector3 = Vector3.ZERO
var _attach_to_ground: bool = true


func _init(target_character: KinematicBody) -> void:
	_target_character = target_character



func update(delta: float) -> void:
	pass



func set_ground_attach(attach_to_ground: bool) -> void:
	_attach_to_ground = attach_to_ground



func apply_motion(velocity: Vector3) -> void:
	# TEMP: Floor normal multiplier will be set in paramters file
	var ground_attach := -_target_character.get_floor_normal() * 2.0 if _attach_to_ground else Vector3.ZERO
	_residual_velocity = _target_character.move_and_slide_with_snap(velocity, ground_attach, Vector3.UP, true)



# TODO: find a better way to get the collider ?
func set_collision_height(height: float) -> void:
	for owner_id in _target_character.get_shape_owners():
		for shape_id in _target_character.shape_owner_get_shape_count(owner_id):
			var shape: Shape = _target_character.shape_owner_get_shape(owner_id, shape_id)
			if shape is CapsuleShape:
				shape = shape as CapsuleShape
				var true_capsule_height := clamp(height - (2.0 * shape.radius), 0.0, 999.0)
				if shape.height == true_capsule_height: 
					return
				shape.height = true_capsule_height
				_target_character.shape_owner_get_owner(owner_id).translation.y = (shape.height / 2.0) + shape.radius
				print("shape height: " + String(shape.height) + " shape translation: " + String(_target_character.shape_owner_get_owner(owner_id).translation.y))



func is_grounded() -> bool:
	return _target_character.is_on_floor()



func is_on_slope() -> bool:
	return _target_character.is_on_wall() && not _target_character.is_on_floor()
