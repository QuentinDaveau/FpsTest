extends Spatial
class_name ArmsStack

"""
Class dedicated to apply transform effects to the equipable root attachement point
(shake, sway...)
"""


export(Array, Script) var behaviors := []

var _player: Player = null
var _behaviors_stack := []



func _ready() -> void:
	_player = Service.fetch(Service.TYPE.FETCH_CHARACTER).from_owner(self)
	if not _player:
		Service.fetch(Service.TYPE.LOG).output(Logger.LEVEL.ERROR, self, "Owner is not a player. This node is expected to be used with a player as owner !")
		return
	_create_stack()
	_generate_attach_point(_player.get_equipable_handler())



func _create_stack() -> void:
	for behavior in behaviors:
		var behavior_node = behavior.new()
		if not behavior_node is ArmsBehaviour:
			var logger := Service.fetch(Service.TYPE.LOG) as Logger
			if logger:
				logger.output(logger.LEVEL.ERROR, self, "Passed object is not a ArmsBehavior!")
			continue
		_add_to_stack(behavior_node)



func _generate_attach_point(equipable_handler: EquipableHandler) -> void:
	var attach_point := EquipableAttachPoint.new(equipable_handler)
	attach_point.name = "AttachPoint"
	if _behaviors_stack.size() > 0:
		_behaviors_stack.back().add_child(attach_point, true)
	else:
		add_child(attach_point, true)



func _add_to_stack(behavior_node: ArmsBehaviour) -> void:
	if _behaviors_stack.size() > 0:
		_behaviors_stack.back().add_child(behavior_node, true)
	else:
		add_child(behavior_node, true)
	_behaviors_stack.append(behavior_node)
