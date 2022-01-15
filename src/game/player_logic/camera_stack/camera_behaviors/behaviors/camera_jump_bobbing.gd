extends CameraBehavior

"""
Class dedicated to handle the jump and land impact bobbing effect
"""

enum STATES {OFF, JUMP, LAND}

var _current_state: int = STATES.OFF
var _player_in_air: bool = false
var _progress: float = 0.0


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")
	set_process(false)


# TODO: Increase land bobbing depending on the landing speed
func _process(delta: float) -> void:
	var _speed = TempGlobals.r.jump_speed if _current_state == STATES.JUMP else TempGlobals.r.land_speed
	_progress += delta / _speed
	
	var bobbing: Curve = TempGlobals.r.jump_bobbing if _current_state == STATES.JUMP else TempGlobals.r.land_bobbing
	var amplitude: float = TempGlobals.r.jump_amplitude if _current_state == STATES.JUMP else TempGlobals.r.land_amplitude
	
	transform.basis = Basis(Vector3(bobbing.interpolate(_progress) * amplitude, 0.0, 0.0))
	
	if _progress >= 1.0:
		_set_state(STATES.OFF)



func _set_state(new_state: int) -> void:
	if _current_state == new_state: return
	_current_state = new_state
	set_process(_current_state != STATES.OFF)
	_progress = 0.0
	
	# TEMP, we may want to do a lerp in the future
	if _current_state == STATES.OFF:
		transform.basis = Basis()



# TEMP: Dirty magic strings
func _on_player_state_changed(var new_state: String) -> void:
	if new_state.begins_with("Jump"):
		_set_state(STATES.JUMP)
		return
	if new_state.begins_with("Fall"):
		_player_in_air = true
		return
	if _player_in_air:
		_set_state(STATES.LAND)
		_player_in_air = false
	
