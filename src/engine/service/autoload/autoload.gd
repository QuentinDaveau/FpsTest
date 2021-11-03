extends Node


const nodes_to_load := [
	preload("res://src/engine/service/services/debug/logger.gd"),
	preload("res://src/engine/service/services/signals.gd"),
	preload("res://src/engine/service/services/character_fetcher.gd"),
	preload("res://src/engine/service/services/input/input_platform/keyboard_input.gd"),
	preload("res://src/engine/service/services/cameras.gd"),
	preload("res://src/engine/service/services/debug/state_ui.gd"),
	preload("res://src/engine/service/services/items.gd"),
]


func _init() -> void:
	for node in nodes_to_load:
		if node is Script:
			add_child(node.new(), true)
		elif node is PackedScene:
			add_child(node.instance(), true)
