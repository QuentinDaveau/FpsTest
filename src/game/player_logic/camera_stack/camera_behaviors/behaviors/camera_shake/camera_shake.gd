extends CameraBehavior
class_name CameraShake

"""
Behaviour dedicated to shake the player's camera
"""



var _ongoing_shakes := {}


# TEMP: See if there isn't a better way than listening for global signals
# (good enouth for test, but will be an issue in the future ?)
func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "shake_camera", "_on_shake_camera")



func _process(delta: float) -> void:
	var basis := Basis()
	for shaker in _ongoing_shakes.values():
		basis *= shaker.rotation
	transform.basis = basis



func _add_shake(shake_data: ShakeData) -> void:
	if _add_to_existing_shake(shake_data):
		return
	var _shaker = BasisShaker.new(shake_data)
	_shaker.connect("shake_all_done", self, "_on_shaker_done", [shake_data.source])
	_ongoing_shakes[shake_data.source] = _shaker
	add_child(_shaker)



func _add_to_existing_shake(data: ShakeData) -> bool:
	if _ongoing_shakes.has(data.source):
		_ongoing_shakes.get(data.source).add_shake(data)
		return true
	return false



func _on_shaker_done(shaker_source: CameraShakeEmitter) -> void:
	_ongoing_shakes.erase(shaker_source)



func _on_shake_camera(data: ShakeData) -> void:
	_add_shake(data)




