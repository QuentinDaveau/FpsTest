extends Resource
class_name WeaponData
tool



# TEMP: With Godot 4.0 it may be possible to directly pass Serializable
export(Array, Resource) var triggers setget _extract_data



func _extract_data(array: Array) -> void:
	for i in range(array.size()):
		var element = array[i]
		if element is Serializable.SerializedData:
			continue
		if element is GDScript:
			var element_instance = element.new()
			if element_instance is Serializable:
				array[i] = element_instance.get_serializable_data()
				continue
		push_error("Given element is not Serializable !")
	triggers = array



class BarrelData:
	pass


class ClipData:
	pass
