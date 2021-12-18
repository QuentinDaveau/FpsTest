extends MarginContainer

"""
Debug UI to display the state of the player
"""

var _labels := []
var _row_container: VBoxContainer


func _ready() -> void:
	add_constant_override("margin_top", 75)
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
	_row_container = VBoxContainer.new()
	_row_container.add_constant_override("separation", 5)
	margin.add_child(_row_container)
	
	var title_label := Label.new()
	title_label.text = "Inventory: "
	_row_container.add_child(title_label)
	
	# Connecting signal
	Service.fetch(Service.TYPE.SIGNAL).listen(self, "inventory_updated", "_on_player_inventory_changed")



func _on_player_inventory_changed(player_inventory: Inventory) -> void:
	for label in _labels:
		label.queue_free()
	_labels.clear()
	for transaction in player_inventory.get_all_items():
		var label := Label.new()
		label.text = ItemDB.TYPE.keys()[transaction.item_type] + ": " + String(transaction.transacted_amount)
		_labels.append(label)
		_row_container.add_child(label)
