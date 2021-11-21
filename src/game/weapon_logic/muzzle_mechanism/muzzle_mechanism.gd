extends Object
class_name MuzzleMechanism

"""
Class dedicated to handle spawning of the given projectile and the spawn logic
(single bullet, multiple, spread values... also include recoil ?)
"""

signal shot()
signal dry_shot()


var _projectile_spawn_location: Position3D


func _init(projectile_spawn_location: Position3D) -> void:
	_projectile_spawn_location = projectile_spawn_location



# TEMP: Wouldn't it make more sens for the dry fire to be handled in the trigger ?
func shoot(projectile: Projectile) -> void:
	if not projectile:
		emit_signal("dry_shot")
	else:
		Service.fetch(Service.TYPE.WORLD_SIMULATION).spawn_projectile(projectile, _projectile_spawn_location.global_transform)
		emit_signal("shot")

