extends Resource
class_name IkJoint

"""
Simple data structure to hold properties of an IK joint
"""


export(NodePath) var target_transform

# Bend angle constraints in euler angles (relative to the forward of the joint)
export(float, 0.0, 180) var constraint = 0.0

export(NodePath) var magnet
