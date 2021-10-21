extends MovementTransition
class_name MovementTransitionConditional

var _transition: MovementTransition


func _init(controller: PlayerController, transition: MovementTransition).(controller) -> void:
	_transition = transition



func get_next_state() -> String:
	return _transition.get_next_state()



func check() -> bool:
	if _check_conditional():
		if _transition.check():
			_raise_state_exit()
			return true
	return false



# To be overriden with the check
func _check_conditional() -> bool:
	return false
