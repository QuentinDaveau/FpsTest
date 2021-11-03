extends Node

enum TYPE {
	INPUT,
	LOG,
	SIGNAL,
	FETCH_CHARACTER,
	CAMERAS,
	ITEM
}


var _registry := {}



func register(source: Node, type: int) -> void:
	_registry[type] = source



func fetch(type: int) -> Node:
	if not _registry.has(type):
		return null
	return _registry.get(type)
