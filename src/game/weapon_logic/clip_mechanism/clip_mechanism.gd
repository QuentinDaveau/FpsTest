extends Object
class_name ClipMechanism

"""
Class dedicated to handle the ammo management logic of the weapon (reload logic,
max ammo...)
"""

signal clip_empty()
signal clip_updated(new_amount, change)
signal clip_refilled()


var _clip_data: ClipData
var _inventory: Inventory



# TODO: Pass parameters in the init to correctly setup the inventory and properties
func _init(clip_data: ClipData) -> void:
	_clip_data = clip_data
	# TEMP: inventory init should be handled in its dedicated class
	# TEMP: for test
	var slot = TypeSlot.new(clip_data.accepted_ammo_type, clip_data.max_ammo_per_clip)
	slot.add(Service.fetch(Service.TYPE.ITEM).generate(ItemDB.TYPE.PISTOL_AMMO, clip_data.max_ammo_per_clip))
	_inventory = Inventory.new([slot])
	_inventory.connect("emptied", self, "is_empty")



# TEMP: See if it is the projectile that handles its own spawning or the weapon / WorldEnvironment
func take_projectile() -> Projectile:
	var result := _inventory.take_group_item(ItemDB.GROUP.AMMO)
	assert(result.item is Projectile or result.item == null, "Clip inventory: retrieved item from clip is not a projectile !")
	emit_signal("clip_updated")
	return result.item as Projectile if result.success else null



# To override
func reload(source_inventory: Inventory) -> void:
	pass



func _is_empty() -> void:
	emit_signal("clip_empty")
