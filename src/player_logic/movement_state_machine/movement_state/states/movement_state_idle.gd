extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Idle"
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, true),
		MovementStateHelper.SetAccelerationAction.new(controller, 0.9),
		MovementStateHelper.IdleAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionToSlip.new(controller),
		MovementStateHelper.TransitionToFall.new(controller),
		MovementStateHelper.TransitionToJump.new(controller),
		MovementStateHelper.TransitionToWalk.new(controller),
	]





