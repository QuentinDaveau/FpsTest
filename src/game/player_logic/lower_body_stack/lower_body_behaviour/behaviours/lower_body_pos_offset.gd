extends LowerBodyBehaviour


"""
Adds a simple offset
"""


# TEMP: position offset will be set in params file
func _ready() -> void:
	transform.origin = Vector3(0.0, -0.6, 0.0)

