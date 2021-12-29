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
	
	var _listeners := []
	var _actions_value: int = 0
	var _changed_values: int = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.FIRE, [1]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.ALT_FIRE, [2]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.RELOAD, [4]))
	
	
	func enter() -> void:
		update()
	
	
	func update() -> void:
		_update_action(_actions_value & 1, 1, Equipable.USAGE.PRIMARY)
		_update_action(_actions_value & 2, 2, Equipable.USAGE.SECONDARY)
		_update_action(_actions_value & 4, 4, Equipable.USAGE.TERTIARY)
	
	
	func exit() -> void:
		_controller.stop_use_equipable(Equipable.USAGE.PRIMARY)
		_controller.stop_use_equipable(Equipable.USAGE.SECONDARY)
		_controller.stop_use_equipable(Equipable.USAGE.TERTIARY)
	
	
	# TEMP: Could be simplified once the equipable has action flags
	func _update_action(action_value: bool, action_id: int, equipable_usage: int) -> void:
		if _changed_values & action_id:
			var result: bool
			if _actions_value & action_id:
				result = _controller.use_equipable(equipable_usage)
			else:
				result = _controller.stop_use_equipable(equipable_usage)
			_actions_value = _actions_value | action_id if result else _actions_value & ~action_id
			_changed_values = _changed_values & ~action_id
	
	
	func _on_action_change(action_value: bool, action_id: int) -> void:
		_actions_value = _actions_value | action_id if action_value else _actions_value & ~action_id
		_changed_values = _changed_values | action_id



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
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.FIRE, [1]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.ALT_FIRE, [2]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.RELOAD, [4]))
	
	
	func get_next_state() -> String:
		return "Idle"
	
	
	func check() -> bool:
		if not _actions_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_action_change(action_value: bool, action_id: int) -> void:
		_actions_value = _actions_value | action_id if action_value else _actions_value & ~action_id



class TransitionToUse:
	extends ArmsTransition
	
	var _listeners := []
	var _actions_value: int = 0
	
	
	func _init(controller: PlayerArmsController).(controller) -> void:
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.FIRE, [1]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.ALT_FIRE, [2]))
		_listeners.append(InputListener.new(self, "_on_action_change", InputListener.TYPE.RELOAD, [4]))
	
	
	func get_next_state() -> String:
		return "UseEquipable"
	
	
	func check() -> bool:
		if _actions_value:
			_raise_state_exit()
			return true
		return false
	
	
	func _on_action_change(action_value: bool, action_id: int) -> void:
		_actions_value = _actions_value | action_id if action_value else _actions_value & ~action_id



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
class ConditionalHasEquipable:
	extends ArmsTransitionConditional
	
	
	func _init(controller: PlayerArmsController, transition: ArmsTransition).(controller, transition) -> void:
		pass
	
	
	func _check_conditional() -> bool:
		return _controller.has_equipable()

