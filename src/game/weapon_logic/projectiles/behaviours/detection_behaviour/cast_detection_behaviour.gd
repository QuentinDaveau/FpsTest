extends DetectionBehaviour
class_name CastDetectionBehaviour



export(int, 999) var _max_cast_distance: int



var _caster: Raycaster



func _handle_spawn() -> void:
	_caster = Raycaster.new(_owner_node.get_world())
	process(0.0)


# TEMP: will need to retrive the collision data in the future
func _handle_process(delta: float) -> void:
	var origin := _owner_node.transform.origin
	if _caster.collides(origin, origin + _owner_node.transform.basis.z.normalized() * _max_cast_distance):
		_on_hit()

