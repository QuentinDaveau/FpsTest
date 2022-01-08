extends DetectionBehaviour
class_name SphereAreaDetectionBehaviour


export(float, 99) var _radius: float
export(Vector3) var _position_offset: Vector3 = Vector3.ZERO


var _collision_area: Area



func _handle_spawn() -> void:
	_collision_area = Area.new()
	_owner_node.add_child(_collision_area)
	_collision_area.owner = _owner_node
	_collision_area.transform.origin = _position_offset
	var shape := CollisionShape.new()
	var sphere := SphereShape.new()
	sphere.radius = _radius
	shape.shape = sphere
	_collision_area.add_child(shape)
	shape.owner = _owner_node
	_collision_area.connect("body_entered", self, "_on_body_entered")



func _on_body_entered(body: Node) -> void:
	_on_hit()
