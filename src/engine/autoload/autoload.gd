extends Node


const nodes_to_load := [
	preload("res://src/engine/service/services/debug/logger.gd"),
	preload("res://src/engine/service/services/character_fetcher/character_fetcher.gd"),
	preload("res://src/engine/service/services/input/input_platform/keyboard_input.gd"),
]


func _init() -> void:
	for node in nodes_to_load:
		add_child(node.new(), true)
