extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "CrouchIdle"
	# TEMP: acceleration, height and speed value will be set in params file. Check other states to ensure it is set correctly everywhere
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, true),
		MovementStateHelper.SetAccelerationAction.new(controller, 15.0),
		MovementStateHelper.SetSpeedAction.new(controller, 0.0),
		MovementStateHelper.SetHeightAction.new(controller, 0.9)
	]
	_transitions = [
		MovementStateHelper.TransitionToSlip.new(controller),
		MovementStateHelper.TransitionToFall.new(controller),
		MovementStateHelper.TransitionCrouchIdleToMove.new(controller),
		MovementStateHelper.TransitionToStand.new(controller),
		MovementStateHelper.TransitionToRun.new(controller),
		MovementStateHelper.TransitionToJump.new(controller),
	]


