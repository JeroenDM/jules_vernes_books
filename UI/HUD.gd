extends Control

export(bool) var enable_food_bar = true
onready var _food_bar : ProgressBar = $FoodBar
onready var _health_bar : ProgressBar = $HealthBar


func _ready():
	$FoodBar.visible = enable_food_bar
	$TextBox.visible = false

func set_food(value : int) -> void:
	if _food_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_food_bar.set_value(clamp(value, 0, _food_bar.get_max()))
	
func set_max_food(value : int) -> void:
	if _food_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_food_bar.set_max(max(1, value))

func set_health(value : int) -> void:
	if _health_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_health_bar.set_value(clamp(value, 0, _health_bar.get_max()))
	
func set_max_health(value : int) -> void:
	if _health_bar == null:
		print("This node should be at the top of the Scene tree")
	else:
		_health_bar.set_max(max(1, value))
		
func show_text(text, time = 3):
	$TextTime.start(time)
	$TextBox/Label.text = text
	$TextBox.visible = true

func hide_text():
	$TextBox.visible = false

func _on_TextTime_timeout():
	hide_text()
