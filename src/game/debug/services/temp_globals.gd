extends Resource

"""
VERY temporary class to store parameters which are supposed to be accessed from
the parameters file in the future
"""

export(Curve) var move_x_bobbing: Curve
export(Curve) var move_y_bobbing: Curve

export(float) var move_x_amplitude: float # Amplitude in rads
export(float) var move_y_amplitude: float

export(float) var move_speed: float

export(float) var visuals_speed_run_coeff: float = 0.8
export(float) var visuals_speed_crouch_coeff: float = 1.2



export(Curve) var jump_bobbing: Curve
export(Curve) var land_bobbing: Curve

export(float) var jump_amplitude: float # Amplitude in rads
export(float) var land_amplitude: float

export(float) var jump_speed: float
export(float) var land_speed: float
