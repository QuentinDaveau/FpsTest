extends Node

"""
Class dedicated to propagate global signals, allowing various components to
interact indirectly with each-other
"""

var _signals := {}



func _init() -> void:
	Service.register(self, Service.TYPE.SIGNAL)



func register(source: Object, signal_name: String) -> void:
	_add_source(source, signal_name)



func listen(listener: Object, signal_name: String, target_function: String) -> void:
	_add_listener(listener, signal_name, target_function)



func _add_listener(listener: Object, signal_name: String, target_function: String) -> void:
	var signal_ref := _init_signal(signal_name)
	signal_ref["listeners"][listener] = target_function
	for source in signal_ref["sources"]:
		source.connect(signal_name, listener, target_function)



func _add_source(source: Object, signal_name: String) -> void:
	var signal_ref := _init_signal(signal_name)
	signal_ref["sources"].append(source)
	for listener in signal_ref["listeners"].keys():
		source.connect(signal_name, listener, signal_ref["listeners"][listener])



func _init_signal(signal_name: String) -> Dictionary:
	if not _signals.has(signal_name):
		_signals[signal_name] = {"sources": [], "listeners": {}}
	return _signals[signal_name]
