extends Spatial


"""
Quick and dirty class to test the IK with the legs
"""

export(NodePath) var _ik_target_left_path
export(NodePath) var _ik_target_right_path

export(NodePath) var _anim_target_left_path
export(NodePath) var _anim_target_right_path

onready var _ik_target_left: Spatial = get_node(_ik_target_left_path)
onready var _ik_target_right: Spatial = get_node(_ik_target_right_path)

onready var _anim_target_left: Spatial = get_node(_anim_target_left_path)
onready var _anim_target_right: Spatial = get_node(_anim_target_right_path)

onready var _caster := Raycaster.new(get_world(), [], 2)



func _physics_process(delta: float) -> void:
	_update_ik_position(_ik_target_left, _anim_target_left)
	_update_ik_position(_ik_target_right, _anim_target_right)



func _update_ik_position(ik_target: Spatial, true_target: Spatial) -> void:
	var _collision_data := _caster.get_collision_data(global_transform.origin, true_target.global_transform.origin)
	if not _collision_data.collides():
		return
	var rotation_axis := (-true_target.global_transform.basis.z).cross(_collision_data.collision_normal()).normalized()
	var rotated_normal := Basis(rotation_axis, _collision_data.collision_normal() , rotation_axis.cross(_collision_data.collision_normal()))
	ik_target.global_transform = Transform(rotated_normal, _collision_data.collision_position())
	



