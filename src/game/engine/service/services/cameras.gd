extends Node
class_name Cameras


var _cameras := []
var _camera_stack := []
var _default_camera: Camera


func _init() -> void:
	Service.register(self, Service.TYPE.CAMERAS)



func register(camera: Camera, take_control: bool = false, is_default: bool = false) -> void:
	if not _cameras.has(camera):
		_cameras.append(camera)
	if is_default:
		_default_camera = camera



func fetch_from_owner(source: Node) -> Camera:
	for camera in _cameras:
		if camera.owner == source.owner:
			return camera
	return null
