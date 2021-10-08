extends Reference
class_name MovementStateHelper

"""
Helper class containing all the actions and transitions that can be used by the
player movement states
"""


# ---------- Actions ----------

# -- Grounded --
class GroundedAction:
	extends MovementAction
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func enter() -> void:
		pass



class IdleAction:
	extends MovementAction
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func enter() -> void:
		_controller.move(Vector2.ZERO, 0.0)





# -- Air --




# -- General --
class MoveAction:
	extends MovementAction
	
	var _listener: InputListener
	var _motion: Vector2 = Vector2.ZERO
	var _motion_updated: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	# TEMP: the move value will be fetched from a "parameters" file
	func update() -> void:
		if _motion_updated:
			_controller.move(_motion, 10.0)
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion = motion_value
		_motion_updated = true



class SetAccelerationAction:
	extends MovementAction
	
	var _acceleration := 0.0
	
	
	#TEMP: Ensure that the injected acceleration value comes from a parameters file
	func _init(controller: PlayerController, acceleration_value: float).(controller) -> void:
		_acceleration = acceleration_value
	
	
	func enter() -> void:
		_controller.set_acceleration(_acceleration)



# ---------- Transitions ----------
class TransitionToWalk:
	extends MovementTransition
	
	var _listener: InputListener
	var _motion_value: Vector2
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	func get_next_state() -> String:
		return "Walk"
	
	
	func check() -> bool:
		if _motion_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion_value = motion_value



class TransitionToIdle:
	extends MovementTransition
	
	var _listener: InputListener
	var _motion_value: Vector2
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	func check() -> bool:
		if not _motion_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion_value = motion_value



class TransitionToFall:
	extends MovementTransition
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func get_next_state() -> String:
		return "Fall"
	
	
	func check() -> bool:
		if not _controller.is_grounded() and not _controller.is_on_slope():
			_raise_state_exit()
			return true
		return false



class TransitionAirToGround:
	extends MovementTransition
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	func check() -> bool:
		if _controller.is_grounded():
			_raise_state_exit()
			return true
		return false



class TransitionAirToSlip:
	extends MovementTransition
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func get_next_state() -> String:
		return "Slip"
	
	
	func check() -> bool:
		if _controller.is_on_slope():
			_raise_state_exit()
			return true
		return false



class TransitionToSlip:
	extends MovementTransition
	
	
	func _init(controller: PlayerController).(controller) -> void:
		pass
	
	
	func get_next_state() -> String:
		return "Slip"
	
	
	func check() -> bool:
		if _controller.is_on_slope() && not _controller.is_grounded():
			_raise_state_exit()
			return true
		return false


