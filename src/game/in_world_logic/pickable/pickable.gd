extends Spatial
class_name Pickable

"""
Quick and dirty pickable test class
"""

export(ItemDB.TYPE) var type: int
export(int, 0, 999) var amount: int = 1

var _inventory: Inventory
var _label: Label3D
var _slot: Slot


func _enter_tree() -> void:
	# TEMP: The inventory data will later come from a centralized data class which will generate the inventory.
	# Put here for now just for tests
	_slot = Slot.new(amount)
	_slot.add(Service.fetch(Service.TYPE.ITEM).generate(type, amount))
	_inventory = Inventory.new([_slot])
	_inventory.connect("updated", self, "_on_inventory_updated")
	
	# Generation of the collision shape
	var area := Area.new()
	area.monitorable = false
	area.connect("body_entered", self, "_on_body_enter")
	add_child(area)
	var shape := CollisionShape.new()
	shape.shape = BoxShape.new()
	area.add_child(shape)
	_label = Label3D.new()
	_label.set_text("TYPE: " + String(ItemDB.TYPE.keys()[type]) + "\nAMOUNT: " + String(amount))
	add_child(_label)
	_label.translate(Vector3.UP * 2)



func _on_body_enter(body: Node) -> void:
	if body is Character and not _inventory.is_empty():
		var character_inventory: InventoryInterface = body.get_inventory()
		character_inventory.receive_item(_inventory)



func _on_inventory_updated() -> void:
	_label.set_text("TYPE: " + String(ItemDB.TYPE.keys()[type]) + "\nAMOUNT: " + String(_slot.get_amount()))
