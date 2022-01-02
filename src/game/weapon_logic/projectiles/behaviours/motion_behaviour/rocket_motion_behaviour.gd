extends MotionBehaviour
class_name RocketMotionBehaviour


export(int, 999) var _speed: int



func _handle_process(delta: float) -> void:
	_owner_node.translate(Vector3.FORWARD * _speed * delta)


