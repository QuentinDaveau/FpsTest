extends Node
class_name Recoiler

"""
Base recoiler class. Can be extended to recoil different properties
"""

enum RECOIL_STATE {OFF, RECOIL, ADD}

signal recoil_all_done()


var _data: RecoilData
var _tween: Tween
var _state: int = RECOIL_STATE.OFF



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


# To override
func _set_tween() -> void:
	pass



func _return_recoil() -> void:
	_state = RECOIL_STATE.RETURN
	_recoil()



func _on_recoil_done() -> void:
	if _state == RECOIL_STATE.RECOIL:
		queue_free()
		emit_signal("recoil_all_done")
		return
