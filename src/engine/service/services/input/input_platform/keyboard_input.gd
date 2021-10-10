extends "../input.gd"

# TEMP: Will be in an option file and accessed from an option class later
const SENSITIVITY := 0.1


# TEMP: Will be handled somewhere else (or called through function)
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		emit_signal("input_received", TYPE.VIEW, event.relative * SENSITIVITY)
		return
	if event is InputEventKey:
		if event.is_echo():
			return
		if _event_is_motion(event):
			emit_signal("input_received", TYPE.MOTION, _get_motion_value())
			return
		if event.is_action("ui_select"):
			emit_signal("input_received", TYPE.JUMP, event.pressed)
		if event.is_action("ui_shift"):
			emit_signal("input_received", TYPE.RUN, event.pressed)



func _event_is_motion(event: InputEvent) -> bool:
	if event.is_action("ui_up") or event.is_action("ui_down"):
		return true
	if event.is_action("ui_left") or event.is_action("ui_right"):
		return true
	return false



# TEMP: Will be more advanced later to take into account only the last pressed key
func _get_motion_value() -> Vector2:
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	return velocity
