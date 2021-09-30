extends Spatial
class_name CameraStack, "res://resources/editor/custom_classes_icons/camera_lens.svg"


export(Array, Script) var behaviors := []

var _behaviors_stack := []



func _ready() -> void:
	_create_stack()
	_generate_camera()



func _create_stack() -> void:
	for behavior in behaviors:
		var behavior_node = behavior.new()
		if not behavior_node is CameraBehavior:
			var logger := Service.fetch(Service.TYPE.LOG) as Logger
			if logger:
				logger.output(logger.LOG_LEVEL.ERROR, self, "Passed object is not a CameraBehavior!")
			continue
		_add_to_stack(behavior_node)



func _generate_camera() -> void:
	var camera := Camera.new()
	if _behaviors_stack.size() > 0:
		_behaviors_stack.back().add_child(camera, true)
	else:
		add_child(camera, true)



func _add_to_stack(behavior_node: CameraBehavior) -> void:
	if _behaviors_stack.size() > 0:
		_behaviors_stack.back().add_child(behavior_node, true)
	else:
		add_child(behavior_node, true)
	_behaviors_stack.append(behavior_node)
