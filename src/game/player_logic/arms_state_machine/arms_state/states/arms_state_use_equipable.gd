extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "UseEquipable"
	
	_actions = [
		ArmsStateHelper.UseAction.new(controller)
	]
	_transitions = [
#		ArmsStateHelper.ConditionalHasFinishedUse.new(
			ArmsStateHelper.TransitionToIdle.new(controller)
	]





