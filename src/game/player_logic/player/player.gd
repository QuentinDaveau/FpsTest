extends Character
class_name Player

"""
Player class. Serves as a container for its different components
"""

export(Vector3) var head_position := Vector3(0.0, 1.35, 0.0)



func _init() -> void:
	register_controller(PlayerController.new(self))
	# TEMP: The inventory data will later come from a centralized data class which will generate the inventory.
	# Put here for now just for tests
	register_inventory(Inventory.new([TypeSlot.new(ItemDB.TYPE.PISTOL_AMMO, 60), Slot.new(30)]))



func _physics_process(delta: float) -> void:
	_controller.update(delta)
