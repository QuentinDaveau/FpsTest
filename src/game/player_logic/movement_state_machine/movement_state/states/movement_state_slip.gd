extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Slip"
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, false),
		MovementStateHelper.SetHeightAction.new(controller, 1.8),
		MovementStateHelper.IdleAction.new(controller)
	]
	_transitions = [
		MovementStateHelper.TransitionAirToGround.new(controller),
		MovementStateHelper.TransitionToFall.new(controller)
	]
