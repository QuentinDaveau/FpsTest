extends Spatial
class_name Equipable

"""
Class that represents an item that can be equipped by a character. handles the
base equiping and un-equiping logic.
"""

signal equip_done()
signal unequip_done()


# All of those are to be overridden
func equip() -> void:
	emit_signal("equip_done")



func unequip() -> void:
	emit_signal("unequip_done")



func use() -> void:
	pass



func stop_use() -> void:
	pass

