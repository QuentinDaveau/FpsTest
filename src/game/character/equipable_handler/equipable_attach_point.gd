extends Spatial
class_name EquipableAttachPoint



"""
Simple node used as the root attach point to any equipable
"""

signal equipable_attached(equipable)
signal equipable_detached(equipable)



func _init(equipable_handler: EquipableHandler) -> void:
	equipable_handler.connect("equipped", self, "_on_equipped")
	equipable_handler.connect("unequipped", self, "_on_unequipped")



func _on_equipped(equipable: Equipable) -> void:
	add_child(equipable)
	emit_signal("equipable_attached", equipable)



func _on_unequipped(equipable: Equipable) -> void:
	remove_child(equipable)
	emit_signal("equipable_detached", equipable)
