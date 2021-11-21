extends Node
class_name InputListener


# TEMP: Should be moved somewhere else and is duplicated in input.gd
enum TYPE {VIEW, MOTION, SHOOT, JUMP, CROUCH, RUN, FIRE, ALT_FIRE}

signal input(value)

var _target_type: int
var _last_input_value


func _init(target: Object, method_name: String, type: int) -> void:
	_target_type = type
	self.connect("input", target, method_name)
	var input := Service.fetch(Service.TYPE.INPUT)
	if input:
		input.connect("input_received", self, "_on_input_received")



func _on_input_received(type: int, value) -> void:
	if type == _target_type:
		emit_signal("input", value)
		_last_input_value = value
