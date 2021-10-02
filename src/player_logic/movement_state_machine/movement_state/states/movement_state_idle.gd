extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Idle"
	_actions = [
		IdleAction.new(controller)
	]
	_transitions = [
		TransitionToWalk.new(controller)
	]



# Actions
class IdleAction:
	extends MovementAction
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass


# Transitions
class TransitionToWalk:
	extends MovementTransition
	
	var _listener: InputListener
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	
	func get_next_state() -> String:
		return "Walk"
	
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		if motion_value:
			_raise_state_exit() 




