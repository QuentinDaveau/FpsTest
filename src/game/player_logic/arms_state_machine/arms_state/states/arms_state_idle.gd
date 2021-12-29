extends ArmsState



func _init(controller: PlayerArmsController).(controller) -> void:
	pass



func _setup_state(controller: PlayerArmsController) -> void:
	_identifier = "Idle"
	
	_actions = [
		
	]
	_transitions = [
		ArmsStateHelper.ConditionalHasEquipable.new(controller, ArmsStateHelper.TransitionToUse.new(controller)),
	]





