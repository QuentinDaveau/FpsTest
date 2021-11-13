extends Node


signal input_received(type, value)


func _init() -> void:
	Service.register(self, Service.TYPE.FETCH_CHARACTER)



func from_owner(source: Node) -> Player:
	var source_owner = source.owner
	if source_owner is Player:
		return source_owner
	else:
		return null
