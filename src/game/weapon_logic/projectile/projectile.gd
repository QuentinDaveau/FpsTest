extends Spatial
class_name Projectile


# TODO: May need to separate the spawning data and the projectile behaviour in two different classes
# (i.e. a ProjectileSpawner which is a container for the projectile and its spawn
# behavior and a Projectile which is the projectile itself)

"""
Data and logic class dedicated to handle the projectile behaviour, such as the
type, the damage, the spawn logic, etc
"""


# TODO: handle projectile data


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


