extends Equipable
class_name Weapon
tool

"""
Class dedicated to hold and initialize the weapon data, as well as being the
interface between the differents components and the users (IA, player...)
"""


const MUZZLE_LOCATION: String = "MuzzleLocation"

export(Resource) var _weapon_data: Resource setget _check_weapon_data_type

var _mechanisms := []



func _set_data(data: EquipableData) -> void:
	_apply_data()
	._set_data(_weapon_data)



func _ready() -> void:
	if Engine.editor_hint:
		_check_and_create_muzzle(MUZZLE_LOCATION)


# TEMP for test
func _apply_data() -> void:
	_weapon_data = _weapon_data as WeaponData
	var c
	for clip in _weapon_data.clips:
		c = ClipMagazine.new(clip)
		_mechanisms.append(c)
	var m
	for muzzle in _weapon_data.muzzles:
		m = MuzzleMechanism.new(get_node(MUZZLE_LOCATION))
		_mechanisms.append(m)
	for trigger in _weapon_data.triggers:
		var t := TriggerSingleFire.new(trigger)
		t.connect("action", self, "_on_trigger_action", [t, c, m])
		_mechanisms.append(t)



func _on_trigger_action(trigger: TriggerMechanism, target_clip: ClipMechanism, target_muzzle: MuzzleMechanism) -> void:
	var projectile := target_clip.take_projectile()
	if not projectile:
		# Dry fire
		return
	target_muzzle.shoot(projectile)



# TEMP for test
func reload(source_inventory: InventoryInterface) -> void:
	for mech in _mechanisms:
		if mech is ClipMechanism:
			mech.reload(source_inventory)



# TEMP for test
#override
func use(usage: int) -> void:
	.use(usage)
	if usage == USAGE.PRIMARY:
		for mech in _mechanisms:
			if mech is TriggerMechanism:
				mech.press()
	elif usage == USAGE.TERTIARY:
		reload(_owner_inventory)


#override
func stop_use(usage: int) -> void:
	.stop_use(usage)
	if usage == USAGE.PRIMARY:
		for mech in _mechanisms:
			if mech is TriggerMechanism:
				mech.release()






# ------------- Editor -----------------

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

