extends Node
class_name Shaker

"""
Base shaker class. Can be extended to shake different properties
"""


signal shake_all_done()


var _data: ShakeData
var _tween: Tween



func _init(data: ShakeData) -> void:
	_data = data



func _ready() -> void:
	_tween = Tween.new()
	add_child(_tween)
	_tween.connect("tween_all_completed", self, "_on_shake_done")
	_shake()



func add_shake(new_data: ShakeData) -> void:
#	_data.direction = (_data.direction + new_data.direction.reflect(_data.direction)).normalized()
	_data.strength += new_data.strength
	_data.speed = new_data.speed



func _shake() -> void:
	_set_tween()
	_tween.start()


# To override
func _set_tween() -> void:
	pass



# To override
func _shake_under_threshold() -> bool:
	return true



func _update_shake() -> void:
	_data.direction = -_data.direction.rotated(_data.random * rand_range(-PI, PI) / 2.0).normalized()
	_data.strength *= 1.0 - _data.damp
	_data.speed *= 1.0 - _data.damp
	_shake()



func _on_shake_done() -> void:
	if _shake_under_threshold():
		queue_free()
		emit_signal("shake_all_done")
		return
	_update_shake()
