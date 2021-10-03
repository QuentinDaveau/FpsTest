extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Idle"
	_actions = [
		MovementStateHelper.IdleAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionToWalk.new(controller)
	]





