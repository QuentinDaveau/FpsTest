extends Spatial
class_name Weapon
tool

"""
Class dedicated to hold and initialize the weapon data, as well as being the
interface between the differents components and the users (IA, player...)
"""


const MUZZLE_LOCATION: String = "MuzzleLocation"

export(Resource) var _weapon_data: Resource setget _check_weapon_data_type

var _shoot_mechanisms := []




func _ready() -> void:
	if Engine.editor_hint:
		_check_and_create_muzzle(MUZZLE_LOCATION)
	



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
	if value is WeaponData:
		_weapon_data = value
	else:
		push_error("The given weapon data resource is not of type WeaponData !")

