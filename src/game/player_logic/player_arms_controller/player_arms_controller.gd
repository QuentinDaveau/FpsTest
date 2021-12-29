extends Node
class_name PlayerArmsController

"""
Class dedicated to control the arms of the player depending on his actions
and the state of the equipped item. Is controlled by the arms state machine
and is used as an interface between the state machine and the equipable
"""

# TEMP: Maybe the state achine can know both the controller and the equipable ?
# Right now the controller seems to a lot of the same things that the equipable handler

var _player_equipable: PlayerEquipableHandler


func _init(player_equipable: PlayerEquipableHandler) -> void:
	_player_equipable = player_equipable



func is_using(use: int) -> bool:
	return _player_equipable.is_using(use)



func use_equipable(usage: int) -> bool:
	return _player_equipable.set_use(usage)



func stop_use_equipable(usage: int) -> bool:
	return _player_equipable.set_use(usage, false)
