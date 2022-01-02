extends Reference
class_name TriggerMechanism


"""
Class dedicated to handle the shooting behaviour when the weapon is triggered
(Single-shot, auto, burst, charge...)
"""

signal action()


var _data: TriggerData

var _cooldown: Timer



func _init(trigger_data: TriggerData) -> void:
	_data = trigger_data
	_cooldown = Timer.new()



func press() -> void:
	pass



func release() -> void:
	pass



func _shoot_projectile() -> void:
	emit_signal("action")
#	_muzzle_mechanism.shoot(_clip_mechanism.take_projectile())
#	_cooldown.start(_data.cooldown_between_shots)


