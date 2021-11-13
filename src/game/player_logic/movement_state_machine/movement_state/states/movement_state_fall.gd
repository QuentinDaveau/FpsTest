extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Fall"
	_actions = [
		# TEMP: Acceleration and speed value will come from a parameters file
		# TODO: When falling against wall: ensures that the state does not flicker between fall and slip
		MovementStateHelper.SetGroundAttachAction.new(controller, false),
		MovementStateHelper.SetAccelerationAction.new(controller, 0.5),
		MovementStateHelper.SetMaxSpeedAction.new(controller, 20.0),
		MovementStateHelper.SetHeightAction.new(controller, 1.8),
		MovementStateHelper.MoveAction.new(controller)
	]
	_transitions = [
		# TEMP
		MovementStateHelper.TransitionAirToGround.new(controller),
		MovementStateHelper.TransitionToSlip.new(controller)
	]

