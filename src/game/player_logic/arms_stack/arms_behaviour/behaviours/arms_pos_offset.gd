extends ArmsBehaviour


"""
Makes the weapon follow the camera forward
"""


# TEMP: equipable position offset will be set in params file
func _ready() -> void:
	transform.origin = Vector3(0.3, -0.2, -0.3)

