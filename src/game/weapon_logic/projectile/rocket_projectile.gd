extends Projectile
class_name RocketProjectile
tool

"""
Basic projectile class which is dedicated to spawn an object and move it until
it collides
"""

# TEMP: This will be set in a data class
const SPEED: float = 10.0

export(NodePath) var _collision_area_path


var _collision_area: Area


func _ready() -> void:
	if Engine.editor_hint:
		_editor_ready()



# ---------------- Override -------------


func _handle_spawn_logic() -> void:
	_collision_area = get_node(_collision_area_path)



func _handle_process_logic(delta: float) -> void:
	translate(-Vector3.FORWARD * SPEED * delta)



# ---------------- Editor ---------------

func _editor_ready() -> void:
	if not _collision_area_path:
		_collision_area = Area.new()
		add_child(_collision_area)
		_collision_area.owner = self
		var shape = CollisionShape.new()
		shape.shape = SphereShape.new()
		_collision_area.add_child(shape)
		shape.owner = self
		_collision_area_path = get_path_to(_collision_area)
