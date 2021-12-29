extends Node
class_name ArmsStateMachine

"""
Class dedicated to load, update and transition between different PlayerArmsStates
"""

signal arms_state_changed(new_state)

export(Array, Script) var states_paths := []

var _arms_controller: PlayerArmsController = null
var _states := {}
var _starting_state_identifier := ""
var _current_state: ArmsState = null


func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "arms_state_changed")
	# Fetching controller to pass to the states
	_arms_controller = Service.fetch(Service.TYPE.FETCH_CHARACTER).from_owner(self).get_arms_controller()
	if not _arms_controller or not _arms_controller is PlayerArmsController:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Owner is not a player. This node is expected to be used with a player as owner !")
		return
	# Initializing states
	for state_path in states_paths:
		var state: ArmsState = state_path.new(_arms_controller)
		_states[state.get_identifier()] = state
		if not _starting_state_identifier:
			_starting_state_identifier = state.get_identifier()
	if _states.size() > 0:
		_enter_state(_states[_starting_state_identifier])
	else:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.WARNING, self, "This state machine has no states!")
		# TEMP: For the arms: Physic process or process ?
		set_physics_process(false)



func _physics_process(delta: float) -> void:
	_current_state.update()



func _enter_state(state: ArmsState) -> void:
	_current_state = state
	for transition in _current_state.get_transitions():
		transition.connect("state_exit", self, "_on_state_exit", [transition.get_next_state()])
	if _current_state.enter():
		emit_signal("arms_state_changed", state.get_identifier())



func _on_state_exit(next_state: String) -> void:
	Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.INFO, self, "Transitioning from " + _current_state.get_identifier() + " to " + next_state)
	for transition in _current_state.get_transitions():
		transition.disconnect("state_exit", self, "_on_state_exit")
	_current_state.exit()
	if not _states.has(next_state):
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Cannot transition to asked state: " + next_state + ", state is missing !")
		return
	_enter_state(_states[next_state])
