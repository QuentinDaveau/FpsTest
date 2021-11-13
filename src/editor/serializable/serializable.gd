extends Object
class_name Serializable
tool




# To be overridden
func get_serializable_data() -> Resource:
	push_error("Missing serialized data !")
	return null



class SerializedData:
	extends Resource
	tool
	
	
	# To be overridden with an instance of the target class
	# TEMP: Maybe find a better way to handle this ?
	func get_target_class() -> Object:
		return null

