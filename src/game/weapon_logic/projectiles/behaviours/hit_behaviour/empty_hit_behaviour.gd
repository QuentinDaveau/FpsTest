extends HitBehaviour
class_name EmptyHitBehaviour



func on_hit() -> void:
	emit_signal("hit_done")

