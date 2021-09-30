extends CameraBehavior


var rot_x = 0
var rot_y = 0


func _ready() -> void:
	add_child(InputListener.new(self, "_move_camera_x", InputListener.TYPE.VIEWX), true)
	add_child(InputListener.new(self, "_move_camera_y", InputListener.TYPE.VIEWY), true)



func _move_camera_x(amount: float) -> void:
	rot_x += deg2rad(-amount)
	transform.basis = Basis(Vector3.RIGHT, rot_y) # reset rotation
	rotate_object_local(Vector3.UP, rot_x)



func _move_camera_y(amount: float) -> void:
	rot_y += deg2rad(-amount)
	transform.basis = Basis(Vector3.UP, rot_x) # reset rotation
	rotate_object_local(Vector3.RIGHT, rot_y)
