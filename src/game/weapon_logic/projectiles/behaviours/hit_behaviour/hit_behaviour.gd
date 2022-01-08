extends ProjectileBehaviour
class_name HitBehaviour

"""
Behaviour dedicated to process action to apply on hit (explode, damage...)
"""


signal hit_done()


func process_hit() -> void:
	pass



# TEMP: will be completed with damage info (who is hit...) in the future
func on_hit() -> void:
	pass
