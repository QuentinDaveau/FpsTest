extends Node
class_name CameraShakeEmitter


signal shake_camera(data)

export(Resource) var _shake_data



func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).register(self, "shake_camera")



func _shake_camera() -> void:
	var duplicated_data = _shake_data.duplicate()
	duplicated_data.source = self
	emit_signal("shake_camera", duplicated_data)
