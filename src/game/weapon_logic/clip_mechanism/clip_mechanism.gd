extends Node
class_name ClipMechanism

"""
Class dedicated to handle the ammo management logic of the weapon
"""

signal clip_empty()
signal clip_updated(new_amount, change)
signal clip_refilled()


var _inventory: Inventory



# TEMP: See if it is the projectile that handles its own spawning or the weapon / WorldEnvironment
func take_projectile() -> Projectile:
	return null


