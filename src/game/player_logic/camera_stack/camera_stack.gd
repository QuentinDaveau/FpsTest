extends Spatial
class_name CameraStack, "res://resources/editor/custom_classes_icons/camera_lens.svg"


export(Array, Script) var behaviors := []

var _player: Player = null
var _behaviors_stack := []



func _ready() -> void:
	_create_stack()
	_generate_camera()
	_player = Service.fetch(Service.TYPE.FETCH_CHARACTER).from_owner(self)
	if not _player:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Owner is not a player. This node is expected to be used with a player as owner !")
		return



func _create_stack() -> void:
	for behavior in behaviors:
		var behavior_node = behavior.new()
		if not behavior_node is CameraBehavior:
			var logger := Service.fetch(Service.TYPE.LOG) as Logger
			if logger:
				logger.output(logger.LEVEL.ERROR, self, "Passed object is not a CameraBehavior!")
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
