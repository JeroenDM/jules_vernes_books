extends Control

onready var _food_bar : ProgressBar = $FoodBar


func set_food(value : int) -> void:
	if _food_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_food_bar.set_value(value)
	
func set_max_food(value : int) -> void:
	if _food_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_food_bar.set_max(value)
