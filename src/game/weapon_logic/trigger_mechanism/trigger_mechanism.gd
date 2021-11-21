extends Object
class_name TriggerMechanism


"""
Class dedicated to handle the shooting behaviour when the weapon is triggered
(Single-shot, auto, burst, charge...)
TEMP: Root class which handle the interaction between the ammo and barrel ? 
"""


# TEMP, should try to decouple later
var _clip_mechanism: ClipMechanism
var _muzzle_mechanism: MuzzleMechanism

var _data: TriggerData

var _cooldown: Timer



func _init(clip_mechanism: ClipMechanism, muzzle_mechanism: MuzzleMechanism, trigger_data: TriggerData) -> void:
	_clip_mechanism = clip_mechanism
	_muzzle_mechanism = muzzle_mechanism
	_data = trigger_data
	_cooldown = Timer.new()



func trigger() -> void:
	pass



func release() -> void:
	pass



func _shoot_projectile() -> void:
	_muzzle_mechanism.shoot(_clip_mechanism.take_projectile())
	_cooldown.start(_data.cooldown_between_shots)


