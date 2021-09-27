extends Node


enum LOG_LEVEL {
	INFO,
	DEBUG,
	WARNING,
	ERROR
}



func output(log_level: int, src_node: Node, message: String) -> void:
	var timed_message = ""
	timed_message += String(Engine.get_frames_drawn()) + "f, "
	timed_message += String(OS.get_ticks_msec() / 1000.0) + "s, "
	timed_message += src_node.name.to_upper() + ": "
	timed_message += message
	match log_level:
		LOG_LEVEL.INFO:
			print(timed_message)
		LOG_LEVEL.DEBUG:
			print_debug(timed_message)
		LOG_LEVEL.WARNING:
			push_warning(timed_message)
		LOG_LEVEL.ERROR:
			push_error(timed_message)
