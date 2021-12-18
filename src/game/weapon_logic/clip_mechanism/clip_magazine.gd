extends ClipMechanism
class_name ClipMagazine




func _init(clip_data: ClipMagazineData).(clip_data) -> void:
	pass



# To override
func reload(source_inventory: Inventory) -> void:
	var missing_amount: int = _clip_data.max_ammo_per_clip - _inventory.get_type_item_amount(_clip_data.accepted_ammo_type)
	if missing_amount == 0:
		return
	var result := source_inventory.push_type_item(_inventory, _clip_data.accepted_ammo_type, missing_amount)
	if result.transacted_amount == 0:
		return
	emit_signal("clip_updated", _inventory.get_type_item_amount(_clip_data.accepted_ammo_type), result.transacted_amount)

