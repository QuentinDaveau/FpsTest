extends Shaker
class_name BasisShaker

"""
Shakes a basis. Has to be put in a tree for the tween to work.
"""

# TEMP 4.0: In 4.0, tweens will be handled differently, maybe it will no longer
# need to be in a tree
const STOP_STRENGTH_THRESHOLD: float = 0.001 # rads

var rotation: Basis = Basis()



func _init(data: ShakeData).(data) -> void:
	pass



func _set_tween() -> void:
	_tween.interpolate_property(self, "rotation", rotation,\
				Basis(Vector3(-_data.direction.y, -_data.direction.x, 0.0) * _data.strength),\
				 _data.speed, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)



func _shake_under_threshold() -> bool:
	return _data.strength < STOP_STRENGTH_THRESHOLD



