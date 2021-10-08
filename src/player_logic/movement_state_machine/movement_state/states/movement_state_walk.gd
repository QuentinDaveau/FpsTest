extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Walk"
	_actions = [
		MovementStateHelper.SetAccelerationAction.new(controller, 0.8),
		MovementStateHelper.MoveAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionToSlip.new(controller),
		MovementStateHelper.TransitionToFall.new(controller),
		MovementStateHelper.TransitionToIdle.new(controller),
	]


