extends Node
class_name ArmsRecoilEmitter

# TEMP: Test class

signal recoil_arms(data)

export(Resource) var _recoil_data



func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "recoil_arms")



func _recoil_arms() -> void:
	var duplicated_data = _recoil_data.duplicate()
	duplicated_data.source = self
	emit_signal("recoil_arms", duplicated_data)
