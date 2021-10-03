extends Node
class_name MovementStateMachine

"""
Class dedicated to load, update and transition between different PlayerStates
"""

signal player_state_changed(new_state)

export(Array, Script) var states_paths := []

var _player_controller: PlayerController = null
var _states := {}
var _starting_state_identifier := ""
var _current_state: MovementState = null


func _ready() -> void:
	# Fetching controller to pass to the states
	Service.fetch(Service.TYPE.SIGNAL).register(self, "player_state_changed")
	_player_controller = Service.fetch(Service.TYPE.FETCH_CHARACTER).from_owner(self).get_controller()
	if not _player_controller or not _player_controller is PlayerController:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Owner is not a player. This node is expected to be used with a player as owner !")
		return
	# Initializing states
	for state_path in states_paths:
		var state: MovementState = state_path.new(_player_controller)
		_states[state.get_identifier()] = state
		if not _starting_state_identifier:
			_starting_state_identifier = state.get_identifier()
	if _states.size() > 0:
		_enter_state(_states[_starting_state_identifier])
	else:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.WARNING, self, "This state machine has no states!")
		set_physics_process(false)



func _physics_process(delta: float) -> void:
	_current_state.update()



func _enter_state(state: MovementState) -> void:
	emit_signal("player_state_changed", state.get_identifier())
	_current_state = state
	for transition in _current_state.get_transitions():
		transition.connect("state_exit", self, "_on_state_exit", [transition.get_next_state()])
	_current_state.enter()



func _on_state_exit(next_state: String) -> void:
	Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.INFO, self, "Transitioning to " + next_state + " from " + _current_state.get_identifier())
	for transition in _current_state.get_transitions():
		transition.disconnect("state_exit", self, "_on_state_exit")
	_current_state.exit()
	if not _states.has(next_state):
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Cannot transition to asked state: " + next_state + ", state is missing !")
		return
	_enter_state(_states[next_state])
