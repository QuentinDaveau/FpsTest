extends TriggerMechanism
class_name TriggerSingleFire



func _init(clip_mechanism: ClipMechanism, muzzle_mechanism: MuzzleMechanism, trigger_data: TriggerSingleFireData).(clip_mechanism, muzzle_mechanism, trigger_data) -> void:
	pass



func trigger() -> void:
	_muzzle_mechanism.shoot(_clip_mechanism.take_projectile())



func release() -> void:
	pass

