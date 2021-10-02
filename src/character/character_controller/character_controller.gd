extends Object
class_name CharacterController

"""
Class dedicated to control a character motion. Contains generic functions to
move the target character. The character has to manually call update to get
updated.
"""

# TEMP: _target_character has to be Character. Set to KinematicBody to prevent 
# cyclic dependency error
var _target_character: KinematicBody
var _target_motion: Vector2 = Vector2.ZERO


func _init(target_character: KinematicBody) -> void:
	_target_character = target_character



func update() -> void:
	_target_character.move_and_slide(Vector3(_target_motion.x, 0.0, _target_motion.y))



func set_motion(motion_vector: Vector2) -> void:
	_target_motion = motion_vector
