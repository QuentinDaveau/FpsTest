extends Node
class_name InputListener


# TEMP: Should be moved somewhere else and is dipliacted in input.gd
enum TYPE {VIEWX, VIEWY, MOTIONX, MOTIONY, SHOOT}

signal input(value)

var _target_type: int


func _init(target: Node, method_name: String, type: int) -> void:
	_target_type = type
	self.connect("input", target, method_name)
	var input := Service.fetch(Service.TYPE.INPUT)
	if input:
		input.connect("input_received", self, "_on_input_received")



func _on_input_received(type: int, value: float) -> void:
	if type == _target_type:
		emit_signal("input", value)
