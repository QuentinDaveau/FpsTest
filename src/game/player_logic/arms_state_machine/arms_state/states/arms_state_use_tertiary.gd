extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "UseTertiary"
	
	_actions = [
		ArmsStateHelper.UseAction.new(controller, Equipable.USAGE.TERTIARY)
	]
	_transitions = [
		ArmsStateHelper.TransitionToUsePrimary.new(controller),
		ArmsStateHelper.TransitionToUseSecondary.new(controller),
		ArmsStateHelper.TransitionToIdle.new(controller)
	]





