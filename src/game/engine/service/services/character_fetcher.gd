extends Node


# TEMP
var _player: Player


func _init() -> void:
	Service.register(self, Service.TYPE.FETCH_CHARACTER)



func from_owner(source: Node) -> Player:
	var source_owner = source.owner
	if source_owner is Player:
		_player = source_owner
		return source_owner
	else:
		return null



func from_cache() -> Player:
	return _player
