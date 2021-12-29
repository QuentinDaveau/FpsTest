extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "UsePrimary"
	
	_actions = [
		ArmsStateHelper.UseAction.new(controller, Equipable.USAGE.PRIMARY)
	]
	_transitions = [
#		ArmsStateHelper.ConditionalHasFinishedUse.new(
			ArmsStateHelper.TransitionToUseSecondary.new(controller),
#		ArmsStateHelper.ConditionalHasFinishedUse.new(
			ArmsStateHelper.TransitionToUseTertiary.new(controller),
#		ArmsStateHelper.ConditionalHasFinishedUse.new(
			ArmsStateHelper.TransitionToIdle.new(controller)
	]





