extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Jump"
	# TEMP: Jump impulse value and acceleration will be set in a parameters file
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, false),
		MovementStateHelper.ApplyImpulseAction.new(controller, Vector3.UP * 5.0),
		MovementStateHelper.SetAccelerationAction.new(controller, 0.5),
		MovementStateHelper.SetHeightAction.new(controller, 1.8),
	]
	_transitions = [
#		MovementStateHelper.TransitionAirToGround.new(controller),
		MovementStateHelper.TransitionToFall.new(controller),
		MovementStateHelper.TransitionAirToSlip.new(controller)
	]


