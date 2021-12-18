extends Node


const nodes_to_load := [
	preload("res://src/game/debug/services/inventory_ui.gd"),
	preload("res://src/game/engine/service/services/signals.gd"),
	preload("res://src/game/engine/service/services/character_fetcher.gd"),
	preload("res://src/game/engine/service/services/input/input_platform/keyboard_input.gd"),
	preload("res://src/game/engine/service/services/cameras.gd"),
	preload("res://src/game/debug/services/logger.gd"),
	preload("res://src/game/engine/service/services/item.gd"),
	preload("res://src/game/engine/service/services/world_simulation.gd"),
	preload("res://src/game/debug/services/state_ui.gd")
]


func _init() -> void:
	for node in nodes_to_load:
		if node is Script:
			add_child(node.new(), true)
		elif node is PackedScene:
			add_child(node.instance(), true)
