extends Spatial
class_name Projectile


# TODO: May need to separate the spawning data and the projectile behaviour in two different classes
# (i.e. a ProjectileSpawner which is a container for the projectile and its spawn
# behavior and a Projectile which is the projectile itself)

"""
Data and logic class dedicated to handle the projectile behaviours, such as the
type, the damage, the spawn logic, etc
"""

# TEMP 4.0: make sure that the passed resource is the correct type
export(Resource) var _life_behaviour
export(Resource) var _motion_behaviour
export(Resource) var _detection_behaviour
export(Resource) var _hit_behaviour




func _ready() -> void:
	if not Engine.editor_hint:
		_handle_spawn_logic()



func _physics_process(delta: float) -> void:
	if not Engine.editor_hint:
		_handle_process_logic(delta)



# To be overridden by different projectiles types
func _handle_spawn_logic() -> void:
	pass



# To be overridden as well 
func _handle_process_logic(delta: float) -> void:
	pass

