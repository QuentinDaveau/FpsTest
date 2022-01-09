extends Node
class_name CameraRecoilEmitter


signal recoil_camera(data)

export(Resource) var _recoil_data



func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "recoil_camera")



func _recoil_camera() -> void:
	var duplicated_data = _recoil_data.duplicate()
	duplicated_data.source = self
	emit_signal("recoil_camera", duplicated_data)
