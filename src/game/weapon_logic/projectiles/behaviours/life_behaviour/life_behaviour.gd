extends ProjectileBehaviour
class_name LifeBehaviour

"""
Behaviour dedicated to process projectile lifespan (auto-destroy...)
"""


signal decayed()



func _decay() -> void:
	emit_signal("decayed")

