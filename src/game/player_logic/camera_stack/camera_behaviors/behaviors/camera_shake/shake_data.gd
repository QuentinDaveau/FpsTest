extends Resource
class_name ShakeData

# TEMP: Do we leave it like that ?
export(Vector2) var direction: Vector2
export(float) var strength: float
export(float) var damp: float
export(float) var random: float
export(float) var speed: float

var source: CameraShakeEmitter
