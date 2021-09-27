extends Spatial
class_name PlayerSpawner, "res://resources/editor/custom_classes_icons/player_spawner.svg"


var _player = preload("res://assets/characters/character/player/Player.tscn")



func _ready() -> void:
	var player = _player.instance()
	owner.call_deferred("add_child", player)
