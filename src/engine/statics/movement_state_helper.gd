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
		_controller.move(Vector2.ZERO)



class SetHeightAction:
	extends MovementAction
	
	var _height_value: float
	
	
	func _init(controller: PlayerController, height_value: float).(controller) -> void:
		_height_value = height_value
	
	
	func enter() -> void:
		_controller.set_collision_height(_height_value)



# -- Air --
class ApplyImpulseAction:
	extends MovementAction
	
	var _impulse_value: Vector3
	
	
	func _init(controller: PlayerController, impulse_value: Vector3).(controller) -> void:
		_impulse_value = impulse_value
	
	
	func enter() -> void:
		_controller.impulse(_impulse_value)



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
			_controller.move(_motion)
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion = motion_value
		_motion_updated = true



class SetAccelerationAction:
	extends MovementAction
	
	var _acceleration := 0.0
	
	
	# TEMP: Ensure that the injected acceleration value comes from a parameters file
	func _init(controller: PlayerController, acceleration_value: float).(controller) -> void:
		_acceleration = acceleration_value
	
	
	func enter() -> void:
		_controller.set_acceleration(_acceleration)



class SetSpeedAction:
	extends MovementAction
	
	var _speed := 0.0
	
	
	# TEMP: Ensure that the injected acceleration value comes from a parameters file
	func _init(controller: PlayerController, speed_value: float).(controller) -> void:
		_speed = speed_value
	
	
	func enter() -> void:
		_controller.set_max_speed(_speed)



class SetGroundAttachAction:
	extends MovementAction
	
	var _attach_to_ground: bool
	
	
	#TEMP: Ensure that the injected acceleration value comes from a parameters file
	func _init(controller: PlayerController, attach_to_ground: bool).(controller) -> void:
		_attach_to_ground = attach_to_ground
	
	
	func enter() -> void:
		_controller.set_ground_attach(_attach_to_ground)



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



class TransitionToRun:
	extends MovementTransition
	
	var _listener: InputListener
	var _should_run: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_run_change", InputListener.TYPE.RUN)
	
	
	func get_next_state() -> String:
		return "Run"
	
	
	func check() -> bool:
		if _should_run:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_run_change(should_run: bool) -> void:
		_should_run = should_run



class TransitionRunToWalk:
	extends MovementTransition
	
	var _listener: InputListener
	var _should_stop_run: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_run_change", InputListener.TYPE.RUN)
	
	
	func get_next_state() -> String:
		return "Walk"
	
	
	func check() -> bool:
		if _should_stop_run:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_run_change(should_run: bool) -> void:
		_should_stop_run = not should_run



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



class TransitionToJump:
	extends MovementTransition
	
	var _listener: InputListener
	var _should_jump: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_jump_change", InputListener.TYPE.JUMP)
	
	
	func get_next_state() -> String:
		return "Jump"
	
	
	func check() -> bool:
		if _should_jump:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_jump_change(should_jump: bool) -> void:
		_should_jump = should_jump



class TransitionToCrouch:
	extends MovementTransition
	
	var _listener: InputListener
	var _should_crouch: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_crouch_change", InputListener.TYPE.CROUCH)
	
	
	func get_next_state() -> String:
		return "CrouchIdle"
	
	
	func check() -> bool:
		if _should_crouch:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_crouch_change(should_crouch: bool) -> void:
		_should_crouch = should_crouch


# TODO: Add stand check to not un-crouch in walls
class TransitionToStand:
	extends MovementTransition
	
	var _listener: InputListener
	var _should_stand: bool = false
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_crouch_change", InputListener.TYPE.CROUCH)
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	func check() -> bool:
		if _should_stand:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_crouch_change(should_crouch: bool) -> void:
		_should_stand = not should_crouch



class TransitionCrouchIdleToMove:
	extends MovementTransition
	
	var _listener: InputListener
	var _motion_value: Vector2
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	func get_next_state() -> String:
		return "CrouchMove"
	
	
	func check() -> bool:
		if _motion_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion_value = motion_value



class TransitionCrouchMoveToIdle:
	extends MovementTransition
	
	var _listener: InputListener
	var _motion_value: Vector2
	
	
	func _init(controller: PlayerController).(controller) -> void:
		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
	
	
	func get_next_state() -> String:
		return "CrouchIdle"
	
	
	func check() -> bool:
		if not _motion_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_motion_change(motion_value: Vector2) -> void:
		_motion_value = motion_value


# Transitions conditionals


class ConditionHasHeadSpace:
	extends MovementTransitionConditional
	
	var _listener: InputListener
	var _raycaster: Raycaster
	var _check_height: float
	
	
	func _init(controller: PlayerController, check_height: float, transition: MovementTransition).(controller, transition) -> void:
		_check_height = check_height
	
	
	func _check_conditional() -> bool:
		return not _controller.is_cast_colliding(Vector3.UP, _check_height, 1.0)


