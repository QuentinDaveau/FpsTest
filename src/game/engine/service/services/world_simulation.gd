extends Node


var _projectiles_container: Node


func _init() -> void:
	Service.register(self, Service.TYPE.WORLD_SIMULATION)
	_projectiles_container = Node.new()
	add_child(_projectiles_container)



func spawn_projectile(projectile: Projectile, spawn_transform: Transform) -> void:
	projectile.global_transform = spawn_transform
	_projectiles_container.add_child(projectile)
