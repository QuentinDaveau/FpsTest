extends Object
class_name MovementTransition


signal state_exit()

var _controller: PlayerController = null


func _init(controller: PlayerController) -> void:
	_controller = controller



func check() -> bool:
	return false



# To override with the desired next state
func get_next_state() -> String:
	return ""



func _raise_state_exit() -> void:
	emit_signal("state_exit")
