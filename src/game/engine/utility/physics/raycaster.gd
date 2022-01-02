extends Reference
class_name Raycaster


var _world: World
var _objects_to_ignore: Array
var _collision_mask: int


func _init(world: World, objects_to_ignore: Array = [], collision_mask: int = 0x7FFFFFFF) -> void:
	_world = world
	_objects_to_ignore = objects_to_ignore
	_collision_mask = collision_mask



func collides(from: Vector3, to: Vector3) -> bool:
	var space_state = _world.direct_space_state
	return true if space_state.intersect_ray(from, to, _objects_to_ignore, _collision_mask) else false


