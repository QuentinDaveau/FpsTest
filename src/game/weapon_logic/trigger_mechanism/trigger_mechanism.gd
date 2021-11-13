extends Serializable
class_name TriggerMechanism


"""
Class dedicated to handle the shooting behaviour when the weapon is triggered
(Single-shot, auto, burst, charge...)
TEMP: Root class which handle the interaction between the ammo and barrel ? 
"""


# TEMP, should try to decouple later
var _clip_mechanism: ClipMechanism
var _muzzle_mechanism: MuzzleMechanism



func _init(clip_mechanism: ClipMechanism, muzzle_mechanism: MuzzleMechanism) -> void:
	_clip_mechanism = clip_mechanism
	_muzzle_mechanism = muzzle_mechanism



func trigger() -> void:
	pass



func release() -> void:
	pass






func get_serializable_data() -> Resource:
	return TriggerData.new()



class TriggerData:
	extends Serializable.SerializedData
	
	export(float) var cooldown_between_shots = -1
	
	
	
	
