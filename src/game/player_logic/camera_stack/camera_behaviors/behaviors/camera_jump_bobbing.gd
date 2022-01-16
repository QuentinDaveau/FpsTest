extends CameraBehavior

"""
Class dedicated to handle the jump and land impact bobbing effect
"""

enum STATES {OFF, JUMP, LAND}

var _current_state: int = STATES.OFF
var _player_in_air: bool = false
var _progress: float = 0.0
var _air_time: float = 0.0


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")


# TODO: Increase land bobbing depending on the landing speed
# Can simply use this transform global velocity
# TODO: How to shake if looking directly up or down ?
# TEMP solution: increase depending on the air time
func _process(delta: float) -> void:
	if _player_in_air:
		_air_time += delta
	
	if _current_state == STATES.OFF:
		return
	
	var _speed = TempGlobals.r.jump_speed if _current_state == STATES.JUMP else TempGlobals.r.land_speed
	_progress += delta / _speed
	
	var bobbing: Curve = TempGlobals.r.jump_bobbing if _current_state == STATES.JUMP else TempGlobals.r.land_bobbing
	
	# TEMP: Max air time multiplication will be set in params file and maybe not use linear curve ?
	var amplitude: float = TempGlobals.r.jump_amplitude if _current_state == STATES.JUMP else TempGlobals.r.land_amplitude * min(3.0, _air_time)
	
	transform.basis = Basis(Vector3(bobbing.interpolate(_progress) * amplitude, 0.0, 0.0))
	
	if _progress >= 1.0:
		_set_state(STATES.OFF)



func _set_state(new_state: int) -> void:
	if _current_state == new_state: return
	_current_state = new_state
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
		_air_time = 0.0
		return
	if _player_in_air:
		print(_air_time)
		_set_state(STATES.LAND)
		_player_in_air = false
	
