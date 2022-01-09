extends Recoiler
class_name BasisRecoiler

"""
Recoils a basis.
"""


var rotation: Basis = Basis()



func _init(data: RecoilData).(data) -> void:
	pass



func _set_tween() -> void:
	var end_rotation := Basis(Vector3(_data.direction.y, -_data.direction.x, 0.0) * _data.strength)
	
	if _data.rotate_z_axis:
		end_rotation = end_rotation.rotated(Vector3.FORWARD, _data.direction.angle_to(Vector2.DOWN) * _data.rotation_amount)
	
	_tween.interpolate_property(self, "rotation", rotation,\
		end_rotation, _data.recoil_speed, Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	_tween.interpolate_property(self, "rotation", end_rotation, Basis(),\
		_data.return_speed, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, _data.recoil_speed)



