extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "Idle"
	
	_actions = [
		
	]
	_transitions = [
		ArmsStateHelper.TransitionToUsePrimary.new(controller),
		ArmsStateHelper.TransitionToUseSecondary.new(controller),
		ArmsStateHelper.TransitionToUseTertiary.new(controller),
	]





