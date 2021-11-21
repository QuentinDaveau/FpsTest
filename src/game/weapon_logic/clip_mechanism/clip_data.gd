extends Resource
class_name ClipData


export(int, 1, 999) var max_ammo_per_clip = 1
	
# TEMP: once group is remplaced by tag, may need to find a way to display items with specific tag (ammo in this case)
export(ItemDB.TYPE) var accepted_ammo_type

