extends "../input.gd"

# TEMP: Will be in an option file and accessed from an option class later
const SENSITIVITY := 0.1


# TEMP: Will be handled somewhere else (or called through function)
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# TEMP: Will have to rename input mapping to more obvious names
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		emit_signal("input_received", TYPE.VIEW, event.relative * SENSITIVITY)
		return
	if event is InputEventKey:
		if event.is_echo():
			return
		if _event_is_motion(event):
			emit_signal("input_received", TYPE.MOTION, _get_motion_value())
		elif event.is_action("ui_select"):
			emit_signal("input_received", TYPE.JUMP, event.pressed)
		elif event.is_action("ui_shift"):
			emit_signal("input_received", TYPE.RUN, event.pressed)
		elif event.is_action("ui_ctrl"):
			emit_signal("input_received", TYPE.CROUCH, event.pressed)
		elif event.is_action("reload"):
			emit_signal("input_received", TYPE.RELOAD, event.pressed)
	elif event is InputEventMouseButton:
		if event.is_action("ui_lclick"):
			emit_signal("input_received", TYPE.FIRE, event.pressed)
		elif event.is_action("ui_rclick"):
			emit_signal("input_received", TYPE.ALT_FIRE, event.pressed)



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
