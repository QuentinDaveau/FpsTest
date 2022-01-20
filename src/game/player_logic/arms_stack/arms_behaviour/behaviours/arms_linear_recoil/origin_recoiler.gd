extends Node
class_name LinearRecoiler

"""
Class dedicated to handle linear recoil effect
"""

# TEMP: Clean-up the generic recoiler class to be able to use it as a parent of this class
# since a lot of code is repeated.

# Currently using the basis recoiler data structure for ease, but will have to have its own


enum RECOIL_STATE {OFF, RECOIL, ADD}

signal recoil_all_done()


var _data: RecoilData
var _tween: Tween
var _state: int = RECOIL_STATE.OFF

var position: Vector3



func _init(data: RecoilData) -> void:
	_data = data



func _ready() -> void:
	_tween = Tween.new()
	add_child(_tween)
	_tween.connect("tween_all_completed", self, "_on_recoil_done")
	_recoil()



func add_recoil(new_data: RecoilData) -> void:
	_data.direction = new_data.direction.rotated(new_data.random * rand_range(-PI, PI) / 2.0).normalized()
	_data.strength += new_data.strength * (1.0 - pow(_data.strength / _data.max_angle, 2.0)) 
	_state = RECOIL_STATE.ADD
	_tween.stop_all()
	_recoil()



func _recoil() -> void:
	_state = RECOIL_STATE.RECOIL
	_set_tween()
	_tween.start()



func _set_tween() -> void:
	var end_position := Vector3.BACK * _data.strength
	
	_tween.interpolate_property(self, "position", position,\
		end_position, _data.recoil_speed, Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	_tween.interpolate_property(self, "position", end_position, Vector3.ZERO,\
		_data.return_speed, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, _data.recoil_speed)



func _return_recoil() -> void:
	_state = RECOIL_STATE.RETURN
	_recoil()



func _on_recoil_done() -> void:
	if _state == RECOIL_STATE.RECOIL:
		queue_free()
		emit_signal("recoil_all_done")
		return

