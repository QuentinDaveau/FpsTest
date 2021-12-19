extends Resource
class_name EquipableData

"""
Data class used to pass basic equipable information
"""

# TEMP until godot 4.0 ? Has to repeat enum of Equipable here for export to work
enum USAGE {
	PRIMARY,
	SECONDARY,
	TERTIARY
}

export(USAGE, FLAGS) var allowed_usages
