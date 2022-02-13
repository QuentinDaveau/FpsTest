extends Spatial
class_name LowerBodyStack

"""
Class dedicated to apply transform effects to the lower body
"""

# TODO: create a generic "stack" class shared for the camera, the arms and upper and lower bodies

# TEMP
export(PackedScene) var test_legs
export(Array, Script) var behaviors := []

var _player: Player = null
var _behaviors_stack := []



func _ready() -> void:
	_player = Service.fetch(Service.TYPE.FETCH_CHARACTER).from_owner(self)
	if not _player:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Owner is not a player. This node is expected to be used with a player as owner !")
		return
	_create_stack()
	_attach_lower_body()



func _create_stack() -> void:
	for behavior in behaviors:
		var behavior_node = behavior.new()
		if not behavior_node is LowerBodyBehaviour:
			var logger := Service.fetch(Service.TYPE.LOG) as Logger
			if logger:
				logger.output(logger.LEVEL.ERROR, self, "Passed object is not a LowerBodyBehaviour!")
			continue
		_add_to_stack(behavior_node)



func _attach_lower_body() -> void:
	var legs: Spatial = test_legs.instance()
	_behaviors_stack.back().add_child(legs)
	legs.owner = owner



func _add_to_stack(behavior_node: LowerBodyBehaviour) -> void:
	if _behaviors_stack.size() > 0:
		_behaviors_stack.back().add_child(behavior_node, true)
	else:
		add_child(behavior_node, true)
	_behaviors_stack.append(behavior_node)
