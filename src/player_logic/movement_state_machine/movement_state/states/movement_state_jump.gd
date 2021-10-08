extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Jump"
	_actions = [
		MovementStateHelper.SetAccelerationAction.new(controller, 0.1),
	]
	_transitions = [
		MovementStateHelper.TransitionAirToGround(controller)
	]


