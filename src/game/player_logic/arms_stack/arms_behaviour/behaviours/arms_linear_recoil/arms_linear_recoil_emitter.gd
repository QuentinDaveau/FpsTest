extends Node
class_name ArmsLinearRecoilEmitter

# TEMP: Test class

signal linear_recoil_arms(data)

export(Resource) var _recoil_data



func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "linear_recoil_arms")



func _recoil_arms() -> void:
	var duplicated_data = _recoil_data.duplicate()
	duplicated_data.source = self
	emit_signal("linear_recoil_arms", duplicated_data)
