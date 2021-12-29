extends Reference
class_name ArmsState


var _actions := []
var _transitions := []
var _identifier := ""



func _init(controller: PlayerArmsController).() -> void:
	_setup_state(controller)
	for action in _actions:
		if not action is ArmsAction:
			Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Script is not a ArmsAction: " + action.get_script().get_path())
			_actions.erase(action)
			continue
	for transition in _transitions:
		if not transition is ArmsTransition:
			Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Script is not a ArmsTransition: " + transition.get_script().get_path())
			_transitions.erase(transition)
			continue



func enter() -> bool:
	for transition in _transitions:
		if transition.check():
			return false
	for action in _actions:
		action.enter()
	return true



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



# TEMP: Magic string used for identifier, will have to be replaced by an enum at some point
func get_identifier() -> String:
	return _identifier



func _setup_state(controller: PlayerArmsController) -> void:
	pass
