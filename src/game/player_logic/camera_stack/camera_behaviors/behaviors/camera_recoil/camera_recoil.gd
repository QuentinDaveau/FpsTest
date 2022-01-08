extends CameraBehavior

var _player_controller: PlayerController
var _tween: Tween



func _ready() -> void:
	_tween = Tween.new()
	add_child(_tween)
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")



# TEMP: Height and crouch height, as well as crouch speed will be set in a params file
func _set_camera_height(var is_crouching: bool) -> void:
	var stand_height := 1.8
	var crouch_height := 0.9
	var crouch_speed := 0.4
	var current_height := translation.y
	var target_height := crouch_height if is_crouching else stand_height
	if target_height == current_height:
		return
	_tween.stop_all()
	_tween.interpolate_property(self, "translation:y", current_height, \
			target_height, _get_current_height_ratio(is_crouching) * crouch_speed, \
			Tween.TRANS_QUINT, Tween.EASE_OUT)
	_tween.start()



# TEMP: Height and crouch height will be set in a params file
func _get_current_height_ratio(to_crouch: bool) -> float:
	var ratio = clamp((translation.y - 0.9) / (1.8 - 0.9), 0.0, 1.0)
	return ratio if to_crouch else 1.0 - ratio



# TEMP: Dirty magic strings
func _on_player_state_changed(var new_state: String) -> void:
	_set_camera_height(new_state.begins_with("Crouch"))
