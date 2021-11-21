extends Spatial
class_name Weapon
tool

"""
Class dedicated to hold and initialize the weapon data, as well as being the
interface between the differents components and the users (IA, player...)
"""


const MUZZLE_LOCATION: String = "MuzzleLocation"

export(Resource) var _weapon_data: Resource setget _check_weapon_data_type

var _mechanisms := []




func _ready() -> void:
	if Engine.editor_hint:
		_check_and_create_muzzle(MUZZLE_LOCATION)
	else:
		_apply_data()
		# TEMP: Will be later handled in the triggers ?
		add_child(InputListener.new(self, "_on_trigger_press", InputListener.TYPE.FIRE))


# TEMP for test
func _apply_data() -> void:
	_weapon_data = _weapon_data as WeaponData
	var c
	for clip in _weapon_data.clips:
		c = ClipMechanism.new(clip)
		_mechanisms.append(c)
	var m
	for muzzle in _weapon_data.muzzles:
		m = MuzzleMechanism.new(get_node(MUZZLE_LOCATION))
		_mechanisms.append(m)
	for trigger in _weapon_data.triggers:
		_mechanisms.append(TriggerSingleFire.new(c, m, trigger))
	


# TEMP for test
func _on_trigger_press(pressed: bool) -> void:
	for mech in _mechanisms:
		if mech is TriggerMechanism:
			mech.trigger() if pressed else mech.release()



# Editor

func _get_configuration_warning() -> String:
	if not _weapon_data:
		return "Missing weapon data !"
	return ""



func _check_and_create_muzzle(name: String) -> void:
	if not get_node(name):
		var location := Position3D.new()
		location.name = name
		add_child(location)
		location.set_owner(get_tree().edited_scene_root)



func _check_weapon_data_type(value) -> void:
	if not value:
		return
	if value is WeaponData:
		_weapon_data = value
	else:
		push_error("The given weapon data resource is not of type WeaponData !")

