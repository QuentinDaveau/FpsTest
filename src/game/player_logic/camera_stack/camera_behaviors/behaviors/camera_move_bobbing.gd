extends CameraBehavior

"""
Class dedicated to handle the head bobbing effect
"""

enum STATES {OFF, CROUCH, WALK, RUN}

var _current_state: int = STATES.OFF
var _progress: float = 0.0


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")
	set_process(false)


# TEMP: Clean this class
func _process(delta: float) -> void:
	# Missing crouch speed mult
	var _speed = TempGlobals.r.move_speed * (TempGlobals.r.visuals_speed_run_coeff if _current_state == STATES.RUN else (TempGlobals.r.visuals_speed_crouch_coeff if _current_state == STATES.CROUCH else 1.0))
	_progress = fmod(_progress + (delta / _speed), 1.0)
	transform.basis = Basis(Vector3(TempGlobals.r.move_y_bobbing.interpolate(_progress) * TempGlobals.r.move_y_amplitude,\
		TempGlobals.r.move_x_bobbing.interpolate(_progress) * TempGlobals.r.move_x_amplitude, 0.0))



func set_state(new_state: int) -> void:
	if _current_state == new_state: return
	_current_state = new_state
	set_process(_current_state != STATES.OFF)
	
	# TEMP, we may want to do a lerp in the future
	if _current_state == STATES.OFF:
		transform.basis = Basis()
		_progress = 0.0



# TEMP: Dirty magic strings
func _on_player_state_changed(var new_state: String) -> void:
	if new_state.begins_with("Crouch"):
		set_state(STATES.CROUCH)
		return
	if new_state.begins_with("Walk"):
		set_state(STATES.WALK)
		return
	if new_state.begins_with("Run"):
		set_state(STATES.RUN)
		return
	set_state(STATES.OFF)
	
