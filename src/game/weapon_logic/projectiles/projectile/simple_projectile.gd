extends Projectile
class_name SimpleProjectile




# Since the Projectile is expected to be a packed scene, we cannot use init (variables
# won't be set), thus we have to use notifications (that apparently won't propagate
# to children, may cause issues in the future ?)
func _notification(notif: int) -> void:
	if notif != NOTIFICATION_INSTANCED: return
	_life_behaviour.connect("decayed", self, "_on_decay")
	_detection_behaviour.connect("hit", _hit_behaviour, "process_hit")


# Quite dirty. Maybe pass behaviours in an array ? (to have multiple of the same
# type)
func _handle_spawn_logic() -> void:
	_life_behaviour.spawn(self)
	_motion_behaviour.spawn(self)
	_detection_behaviour.spawn(self)
	_hit_behaviour.spawn(self)



func _handle_process_logic(delta: float) -> void:
	_life_behaviour.process(delta)
	_motion_behaviour.process(delta)
	_detection_behaviour.process(delta)
	_hit_behaviour.process(delta)



func _on_decay() -> void:
	queue_free()
