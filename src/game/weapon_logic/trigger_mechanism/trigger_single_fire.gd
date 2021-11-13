extends TriggerMechanism
class_name TriggerSingleFire



func trigger() -> void:
	pass



func release() -> void:
	pass







func get_serializable_data() -> Resource:
	return TriggerData.new()



class TriggerData:
	extends Serializable.SerializedData
	
	
	func get_target_class() -> Object:
		return TriggerSingleFire
