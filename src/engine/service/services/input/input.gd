extends Node


# TEMP: Should be moved smewhere else
enum TYPE {VIEW, MOTION, SHOOT, JUMP, CROUCH, RUN}

signal input_received(type, value)


func _init() -> void:
	Service.register(self, Service.TYPE.INPUT)
