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


func _init(target_character: KinematicBody) -> void:
	_target_character = target_character



func update(delta: float) -> void:
	pass



func apply_motion(velocity: Vector3) -> void:
	_residual_velocity = _target_character.move_and_slide(velocity)

