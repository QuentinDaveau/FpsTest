extends CameraBehavior


var rot_x = 0
var rot_y = 0


func _ready() -> void:
	add_child(InputListener.new(self, "_move_camera", InputListener.TYPE.VIEW), true)



func _move_camera(amount: Vector2) -> void:
	rot_x += deg2rad(-amount.y)
	rot_y += deg2rad(-amount.x)
	transform.basis = Basis(Vector3(rot_x, rot_y, 0.0))
