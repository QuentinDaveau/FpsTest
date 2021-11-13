extends CameraBehavior

signal player_camera_forward_updated(camera_forward)


var _rot_x := 0.0
var _rot_y := 0.0


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "player_camera_forward_updated")
	add_child(InputListener.new(self, "_move_camera", InputListener.TYPE.VIEW), true)



func _move_camera(amount: Vector2) -> void:
	_rot_x += deg2rad(-amount.x)
	_rot_y += deg2rad(-amount.y)
	_rot_y = clamp(_rot_y, -PI/2.1, PI/2.1)
	transform.basis = Basis(Vector3(_rot_y, _rot_x, 0.0))
	emit_signal("player_camera_forward_updated", global_transform.basis.z.normalized())
