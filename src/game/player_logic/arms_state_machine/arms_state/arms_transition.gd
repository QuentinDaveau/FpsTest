extends Reference
class_name ArmsTransition


signal state_exit()

var _controller: PlayerArmsController = null


func _init(controller: PlayerArmsController) -> void:
	_controller = controller



func check() -> bool:
	return false



# To override with the desired next state
func get_next_state() -> String:
	return ""



func _raise_state_exit() -> void:
	emit_signal("state_exit")
