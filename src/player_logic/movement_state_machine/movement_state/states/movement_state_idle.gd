extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Idle"
	# TEMP: acceleration, height and speed value will be set in params file. Check other states to ensure it is set correctly everywhere
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, true),
		MovementStateHelper.SetAccelerationAction.new(controller, 15.0),
		MovementStateHelper.SetMaxSpeedAction.new(controller, 0.0),
		MovementStateHelper.SetHeightAction.new(controller, 1.8)
#		MovementStateHelper.IdleAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionToSlip.new(controller),
		MovementStateHelper.TransitionToFall.new(controller),
		MovementStateHelper.TransitionToJump.new(controller),
		MovementStateHelper.TransitionToWalk.new(controller),
		MovementStateHelper.TransitionToCrouch.new(controller),
	]





