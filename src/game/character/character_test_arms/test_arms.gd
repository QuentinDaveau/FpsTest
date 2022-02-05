extends Spatial


"""
Quick and dirty class to test the IK with the weapons
"""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if owner is Character:
		var attach_point: EquipableAttachPoint = owner.find_node("AttachPoint", true, false)
		attach_point.connect("equipable_attached", self, "_on_weapon_equipped")


func _on_weapon_equipped(equipable: Equipable) -> void:
	print(equipable.get_node("GrabPoint1"))
	$ArmLeft.set_target(equipable.get_node("GrabPoint1"))
	$ArmRight.set_target(equipable.get_node("GrabPoint2"))
