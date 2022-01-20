extends ArmsBehaviour
class_name ArmsLinearRecoil

"""
Behaviour dedicated to apply a linear recoil to the player's arms when shooting
"""



var _ongoing_recoils := {}


# TEMP: See if there isn't a better way than listening for global signals
# (good enouth for test, but will be an issue in the future ?)
func _ready() -> void:
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "linear_recoil_arms", "_on_recoil_arms")



func _process(delta: float) -> void:
	var origin := Vector3.ZERO
	for recoil in _ongoing_recoils.values():
		origin += recoil.position
	transform.origin = origin



func _add_recoil(recoil_data: RecoilData) -> void:
	if _add_to_existing_recoil(recoil_data):
		return
	var _recoiler = LinearRecoiler.new(recoil_data)
	_recoiler.connect("recoil_all_done", self, "_on_recoil_done", [recoil_data.source])
	_ongoing_recoils[recoil_data.source] = _recoiler
	add_child(_recoiler)



func _add_to_existing_recoil(data: RecoilData) -> bool:
	if _ongoing_recoils.has(data.source):
		_ongoing_recoils.get(data.source).add_recoil(data)
		return true
	return false



func _on_recoil_done(recoil_source: ArmsLinearRecoilEmitter) -> void:
	_ongoing_recoils.erase(recoil_source)



func _on_recoil_arms(data: RecoilData) -> void:
	_add_recoil(data)


