extends Node
class_name Logger


enum LEVEL {
	INFO,
	DEBUG,
	WARNING,
	ERROR
}



func _init() -> void:
	Service.register(self, Service.TYPE.LOG)



func output(log_level: int, src_node: Node, message: String) -> void:
	var timed_message = ""
	timed_message += String(Engine.get_frames_drawn()) + "f, "
	timed_message += String(OS.get_ticks_msec() / 1000.0) + "s, "
	timed_message += src_node.name + ": "
	timed_message += message
	match log_level:
		LEVEL.INFO:
			print(timed_message)
		LEVEL.DEBUG:
			print_debug(timed_message)
		LEVEL.WARNING:
			push_warning(timed_message)
		LEVEL.ERROR:
			push_error(timed_message)
