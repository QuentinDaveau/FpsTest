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
var _collider_shape: ShapeInfo
var _raycaster: Raycaster



func _init(target_character: KinematicBody) -> void:
	_target_character = target_character
	target_character.connect("tree_entered", self, "_on_target_ready")



# Have to wait readu() to initialize the caster, otherwise the character has no world yet
func _on_target_ready() -> void:
	_raycaster = Raycaster.new(_target_character.get_world(), _collider_shape.shape if _collider_shape else [])
	_collider_shape = _get_shape_info()



func update(delta: float) -> void:
	pass



func set_ground_attach(attach_to_ground: bool) -> void:
	_attach_to_ground = attach_to_ground



func apply_motion(velocity: Vector3) -> void:
	# TEMP: Floor normal multiplier will be set in paramters file
	var ground_attach := -_target_character.get_floor_normal() * 2.0 if _attach_to_ground else Vector3.ZERO
	_residual_velocity = _target_character.move_and_slide_with_snap(velocity, ground_attach, Vector3.UP, true)



func is_grounded() -> bool:
	return _target_character.is_on_floor()



func is_on_slope() -> bool:
	return _target_character.is_on_wall() and not _target_character.is_on_floor()



# TEMP: Maybe place collision-related stuff in the character itself ?
func is_cast_colliding(direction: Vector3, length: float, character_height_ratio: float, use_local_coords: bool = false) -> bool:
	var global_position := get_position_in_collider(character_height_ratio)
	var cast_vector := (direction if not use_local_coords else _target_character.to_global(direction)).normalized() * length
	return _raycaster.collides(global_position, global_position + cast_vector)



func get_position_in_collider(collider_height_ratio: float) -> Vector3:
	collider_height_ratio = clamp(collider_height_ratio, 0, 1)
	if _collider_shape and _collider_shape.shape is CapsuleShape:
		return _target_character.global_transform.origin + Vector3(0.0, _collider_shape.shape.height + _collider_shape.shape.radius * 2.0, 0.0)
	return Vector3.INF



# TODO: find a better way to get the collider ?
func set_collision_height(height: float) -> void:
	if _collider_shape and _collider_shape.shape is CapsuleShape:
		var shape = _collider_shape.shape
		var true_capsule_height := clamp(height - (2.0 * shape.radius), 0.0, 999.0)
		if shape.height == true_capsule_height: 
			return
		shape.height = true_capsule_height
		_collider_shape.shape_owner.translation.y = (shape.height / 2.0) + shape.radius



func _get_shape_info() -> ShapeInfo:
	for owner_id in _target_character.get_shape_owners():
		for shape_id in _target_character.shape_owner_get_shape_count(owner_id):
			var shape: Shape = _target_character.shape_owner_get_shape(owner_id, shape_id)
			_collider_shape = ShapeInfo.new(shape, _target_character.shape_owner_get_owner(owner_id))
			return _collider_shape
	Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Failed to extract collider from character " + _target_character.name + " !")	
	return null


# Helper class

class ShapeInfo:
	
	var shape: Shape
	var shape_owner: Object
	
	func _init(shape: Shape, shape_owner: Object) -> void:
		self.shape = shape
		self.shape_owner = shape_owner

