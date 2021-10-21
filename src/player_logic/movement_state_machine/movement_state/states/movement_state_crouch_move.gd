extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "CrouchMove"
	# TEMP: acceleration, height and speed value will be set in params file. Check other states to ensure it is set correctly everywhere
	_actions = [
		MovementStateHelper.SetGroundAttachAction.new(controller, true),
		MovementStateHelper.SetAccelerationAction.new(controller, 15.0),
		MovementStateHelper.SetSpeedAction.new(controller, 5.0),
		MovementStateHelper.SetHeightAction.new(controller, 0.9),
		MovementStateHelper.MoveAction.new(controller),
	]
	_transitions = [
		MovementStateHelper.ConditionHasHeadSpace.new(
			controller, 1.0, MovementStateHelper.TransitionToSlip.new(controller)),
		MovementStateHelper.ConditionHasHeadSpace.new(
			controller, 1.0, MovementStateHelper.TransitionToFall.new(controller)),
			
		MovementStateHelper.TransitionCrouchMoveToIdle.new(controller),
		
		MovementStateHelper.ConditionHasHeadSpace.new(
			controller, 1.0, MovementStateHelper.TransitionToStand.new(controller)),
		MovementStateHelper.ConditionHasHeadSpace.new(
			controller, 1.0, MovementStateHelper.TransitionToRun.new(controller)),
		MovementStateHelper.ConditionHasHeadSpace.new(
			controller, 1.0, MovementStateHelper.TransitionToJump.new(controller)),
		
	]


