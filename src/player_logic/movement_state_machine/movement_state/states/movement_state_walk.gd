extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Walk"
	_actions = [
		MovementStateHelper.MoveAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionToIdle.new(controller)
	]





