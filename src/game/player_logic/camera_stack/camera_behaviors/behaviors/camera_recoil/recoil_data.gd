extends Resource
class_name RecoilData

# TEMP: Do we leave it like that ?

# TEMP: At some point, we may want to allow to select between different easings
#export(Curve) var recoil_curve: Curve
export(float) var recoil_speed: float
#export(Curve) var return_curve: Curve
export(float) var return_speed: float
export(Vector2) var direction: Vector2
export(float) var random: float
export(float) var strength: float # Max angle per call in rads
export(float) var max_angle: float # Max angle in rads

export(bool) var rotate_z_axis: bool = false
export(float, 0, 1) var rotation_amount = 0.5

var source: CameraRecoilEmitter
