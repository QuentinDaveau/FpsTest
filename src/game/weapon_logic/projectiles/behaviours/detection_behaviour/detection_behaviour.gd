extends ProjectileBehaviour
class_name DetectionBehaviour

"""
Behaviour dedicated to detect hit (raycast, spherecast, area...)
"""


signal hit()



func _on_hit() -> void:
	emit_signal("hit")
