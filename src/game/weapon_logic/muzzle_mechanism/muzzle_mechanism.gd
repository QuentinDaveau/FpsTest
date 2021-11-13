extends Node
class_name MuzzleMechanism

"""
Class dedicated to handle spawning of the given projectile and the spawn logic
(single bullet, multiple, spread values... also include recoil ?)
"""

signal shot()
signal dry_shot()


const SPAWN_LOCATION_NODE_NAME: String = "ProjectileSpawnLocation"


var _projectile_spawn_location: Position3D


func _ready() -> void:
	if Engine.editor_hint:
		if not get_node(SPAWN_LOCATION_NODE_NAME):
			var spawn_location := Position3D.new()
			spawn_location.name = SPAWN_LOCATION_NODE_NAME
			add_child(spawn_location)
			spawn_location.set_owner(get_tree().edited_scene_root)



# TEMP: Wouldn't it make more sens for the dry fire to be handled in the trigger ?
func shoot(projectile) -> void:
	if not projectile:
		emit_signal("dry_shot")
	else:
		emit_signal("shot")
