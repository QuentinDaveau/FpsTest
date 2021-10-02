extends MovementState



func _init(controller: PlayerController).(controller) -> void:
	pass



func _setup_state(controller: PlayerController) -> void:
	_identifier = "Walk"
	_actions = [
		MoveAction.new(controller)
	]
	_transitions = [
		TransitionToIdle.new(controller)
	]




# Actions
class MoveAction:
	extends MovementAction
	
	var _listener: InputListener
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_controller.set_motion(motion_value)



# Transitions
class TransitionToIdle:
	extends MovementTransition
	
	var _listener: InputListener
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		if not motion_value:
			_raise_state_exit() 

