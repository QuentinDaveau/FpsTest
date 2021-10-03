extends Reference
class_name MovementState


var _actions := []
var _transitions := []
var _identifier := ""



func _init(controller: PlayerController).() -> void:
	_setup_state(controller)
	for action in _actions:
		if not action is MovementAction:
			Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Script is not a MovementAction: " + action.get_script().get_path())
			_actions.erase(action)
			continue
	for transition in _transitions:
		if not transition is MovementTransition:
			Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Script is not a MovementAction: " + transition.get_script().get_path())
			_transitions.erase(transition)
			continue



func enter() -> void:
	for transition in _transitions:
		if transition.check():
			return
	for action in _actions:
		action.enter()



func exit() -> void:
	for action in _actions:
		action.exit()



func update() -> void:
	for action in _actions:
		action.update()
	for transition in _transitions:
		if transition.check():
			return



func get_transitions() -> Array:
	return _transitions



func get_identifier() -> String:
	return _identifier



func _setup_state(controller: PlayerController) -> void:
	pass
