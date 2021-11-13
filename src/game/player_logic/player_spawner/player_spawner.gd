extends Spatial
class_name PlayerSpawner, "res://resources/editor/custom_classes_icons/player_spawner.svg"


const _player = preload("res://assets/characters/character/player/Player.tscn")



func _ready() -> void:
	var player = _player.instance()
	player.global_transform = global_transform
	owner.call_deferred("add_child", player, true)
