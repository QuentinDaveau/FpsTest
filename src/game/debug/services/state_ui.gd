extends MarginContainer

"""
Debug UI to display the state of the player
"""

var _state_label: Label
var _previous_state_label: Label
var _previous_state: String = ""
var _state: String = ""


func _ready() -> void:
	var rect := ColorRect.new()
	rect.color = Color(0.2, 0.2, 0.2, 0.2)
	add_child(rect)
	var margin := MarginContainer.new()
	var margin_value = 10
	margin.add_constant_override("margin_top", margin_value)
	margin.add_constant_override("margin_left", margin_value)
	margin.add_constant_override("margin_bottom", margin_value)
	margin.add_constant_override("margin_right", margin_value)
	add_child(margin)
	var row := VBoxContainer.new()
	row.add_constant_override("separation", 5)
	margin.add_child(row)
	_state_label = Label.new()
	row.add_child(_state_label)
	_previous_state_label = Label.new()
	row.add_child(_previous_state_label)
	# Connecting signal
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "player_state_changed", "_on_player_state_changed")



func _on_player_state_changed(new_state_name: String) -> void:
	_previous_state = _state
	_state = new_state_name
	_update_labels()



func _update_labels() -> void:
	_state_label.text = "Current state: " + _state.to_upper()
	_previous_state_label.text = "Previous_state: " + _previous_state.to_upper()


