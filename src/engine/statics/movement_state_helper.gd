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



# -- Air --



# ---------- Transitions ----------
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

