extends Node


# TEMP: Should be moved smewhere else
enum TYPE {VIEWX, VIEWY, MOTIONX, MOTIONY, SHOOT}

signal input_received(type, value)


func _init() -> void:
	Service.register(self, Service.TYPE.INPUT)
