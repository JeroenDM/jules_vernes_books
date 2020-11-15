extends Control

onready var _food_bar : ProgressBar = $FoodBar
onready var _damage_bar : ProgressBar = $DamageBar


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

func set_damage(value : int) -> void:
	if _damage_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_damage_bar.set_value(value)
	
func set_max_damage(value : int) -> void:
	if _damage_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_damage_bar.set_max(value)
