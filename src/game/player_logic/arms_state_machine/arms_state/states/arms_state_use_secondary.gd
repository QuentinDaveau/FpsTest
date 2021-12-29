extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "UseSecondary"
	
	_actions = [
		ArmsStateHelper.UseAction.new(controller, Equipable.USAGE.SECONDARY)
	]
	_transitions = [
		ArmsStateHelper.TransitionToUsePrimary.new(controller),
		ArmsStateHelper.TransitionToUseTertiary.new(controller),
		ArmsStateHelper.TransitionToIdle.new(controller)
	]





