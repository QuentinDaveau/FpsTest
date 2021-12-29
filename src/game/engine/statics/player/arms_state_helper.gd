extends Reference
class_name ArmsStateHelper

"""
Helper class containing all the actions and transitions that can be used by the
player arms states
"""


# ---------- Actions ----------

# -- Grounded --
#class GroundedAction:
#	extends MovementAction
#
#
#	func _init(controller: PlayerController).(controller) -> void:
#		pass
#
#
#	func enter() -> void:
#		pass



class UseAction:
	extends ArmsAction
	
	var _usage: int
	
	
	func _init(controller: PlayerArmsController, usage: int).(controller) -> void:
		_usage = usage


	func enter() -> void:
		_controller.use_equipable(_usage)
	
	
	
	func exit() -> void:
		_controller.stop_use_equipable(_usage)



# ---------- Transitions ----------
#class TransitionToWalk:
#	extends MovementTransition
#
#	var _listener: InputListener
#	var _motion_value: Vector2
#
#
#	func _init(controller: PlayerController).(controller) -> void:
#		_listener = InputListener.new(self, "_on_motion_change", InputListener.TYPE.MOTION)
#
#
#	func get_next_state() -> String:
#		return "Walk"
#
#
#	func check() -> bool:
#		if _motion_value:
#			_raise_state_exit()
#			return true
#		return false
#
#
#	func _on_motion_change(motion_value: Vector2) -> void:
#		_motion_value = motion_value


class TransitionToIdle:
	extends ArmsTransition
	
	var _listeners := []
	var _actions_value: int = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listeners.append(InputListener.new(self, "_on_primary_change", InputListener.TYPE.FIRE))
		_listeners.append(InputListener.new(self, "_on_secondary_change", InputListener.TYPE.ALT_FIRE))
		_listeners.append(InputListener.new(self, "_on_tertiary_change", InputListener.TYPE.RELOAD))
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	func check() -> bool:
		if not _actions_value:
			_raise_state_exit()
			return true
		return false
	
	
	# TEMP: Find a better way, maybe through a helper class ?
	func _on_primary_change(action_value: bool) -> void:
		_actions_value = _actions_value | 1 if action_value else _actions_value & ~1
		
	func _on_secondary_change(action_value: bool) -> void:
		_actions_value = _actions_value | 2 if action_value else _actions_value & ~2
		
	func _on_tertiary_change(action_value: bool) -> void:
		_actions_value = _actions_value | 4 if action_value else _actions_value & ~4



class TransitionToUsePrimary:
	extends ArmsTransition
	
	var _listener: InputListener
	var _action_value: bool = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listener = InputListener.new(self, "_on_input_change", InputListener.TYPE.FIRE)
	
	
	func get_next_state() -> String:
		return "UsePrimary"
	
	
	func check() -> bool:
		if _action_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_input_change(action_value: bool) -> void:
		_action_value = action_value



class TransitionToUseSecondary:
	extends ArmsTransition
	
	var _listener: InputListener
	var _action_value: bool = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listener = InputListener.new(self, "_on_input_change", InputListener.TYPE.ALT_FIRE)
	
	
	func get_next_state() -> String:
		return "UseSecondary"
	
	
	func check() -> bool:
		if _action_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_input_change(action_value: bool) -> void:
		_action_value = action_value



class TransitionToUseTertiary:
	extends ArmsTransition
	
	var _listener: InputListener
	var _action_value: bool = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listener = InputListener.new(self, "_on_input_change", InputListener.TYPE.RELOAD)
	
	
	func get_next_state() -> String:
		return "UseTertiary"
	
	
	func check() -> bool:
		if _action_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_input_change(action_value: bool) -> void:
		_action_value = action_value



# -------- Transitions conditionals ---------

#
#class ConditionHasHeadSpace:
#	extends MovementTransitionConditional
#
#	var _check_height: float
#
#
#	func _init(controller: PlayerController, check_height: float, transition: MovementTransition).(controller, transition) -> void:
#		_check_height = check_height
#
#
#	func _check_conditional() -> bool:
#		return not _controller.is_cast_colliding(Vector3.UP, _check_height, 1.0)



# TEMP: Conditional not good, logic blocks weapon if weapon is waiting for the input
# to stop use. Temporarily removed.
class ConditionalHasFinishedUse:
	extends ArmsTransitionConditional
	
	var _check_use: int
	
	
	func _init(controller: PlayerArmsController, use: int, transition: ArmsTransition).(controller, transition) -> void:
		_check_use = use
	
	
	func _check_conditional() -> bool:
		return not _controller.is_using(_check_use)

