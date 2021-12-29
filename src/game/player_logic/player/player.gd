extends Character
class_name Player

"""
Player class. Serves as a container for its different components
"""


# TEMP ?
var _arms_controller: PlayerArmsController



func _init() -> void:
	# TEMP: for debug
	Service.fetch(Service.TYPE.SIGNAL).register(self, "inventory_updated")
	register_controller(PlayerController.new(self))
	# TEMP: The inventory data will later come from a centralized data class which will generate the inventory.
	# Put here for now just for tests
	register_inventory(CharacterInventoryInterface.new(Inventory.new([TypeSlot.new(ItemDB.TYPE.PISTOL_AMMO, 60), Slot.new(30)])))
	register_equipable_handler(PlayerEquipableHandler.new(get_inventory()))
	_arms_controller = PlayerArmsController.new(get_equipable_handler())



func _physics_process(delta: float) -> void:
	_controller.update(delta)



func get_arms_controller() -> PlayerArmsController:
	return _arms_controller

