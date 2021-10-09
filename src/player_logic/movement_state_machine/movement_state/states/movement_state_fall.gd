extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Fall"
	_actions = [
		# TEMP: Acceleration value will come from a parameters file
		MovementStateHelper.SetGroundAttachAction.new(controller, false),
		MovementStateHelper.SetAccelerationAction.new(controller, 0.05),
		MovementStateHelper.MoveAction.new(controller)
	]
	_transitions = [
		# TEMP
		MovementStateHelper.TransitionAirToGround.new(controller),
		MovementStateHelper.TransitionToSlip.new(controller)
	]

