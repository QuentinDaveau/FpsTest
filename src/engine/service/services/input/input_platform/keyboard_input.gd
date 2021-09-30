extends "../input.gd"

# TEMP: Will be in an option file and accessed from an option class later
const SENSITIVITY := 0.1

# TEMP: Will be handled somewhere else (or called through function)
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		emit_signal("input_received", TYPE.VIEWX, event.relative.x * SENSITIVITY)
		emit_signal("input_received", TYPE.VIEWY, event.relative.y * SENSITIVITY)
