extends LifeBehaviour
class_name DelayLifeBehaviour


export(float, 999) var _lifetime: float


var _current_lifetime := 0.0
var _should_process := true



func _handle_process(delta: float) -> void:
	if not _should_process:
		return
	_current_lifetime += delta
	if _current_lifetime >= _lifetime:
		_decay()
		_should_process = false

