extends Control

export(bool) var enable_food_bar = true
onready var food_bar : ProgressBar = $FoodBar
onready var health_bar : ProgressBar = $HealthBar


func _ready():
	$FoodBar.visible = enable_food_bar
	$TextBox.visible = false
	
	PlayerData.connect("health_changed", self, "update_health")
	PlayerData.connect("fuel_changed", self, "update_fuel")
	PlayerData.connect("bleed", self, "bleed")
	
	health_bar.set_max(PlayerData.max_health)
	food_bar.set_max(PlayerData.max_fuel)


func update_fuel(value : float) -> void:
	food_bar.set_value(PlayerData.fuel)


func update_health(value : int) -> void:
	health_bar.set_value(PlayerData.health)
	
func bleed() -> void:
	$Panel.visible = true
	$BleedTimer.start()


func stop_bleeding() -> void:
	$Panel.visible = false


func show_text(text, time = 3):
	$TextTime.start(time)
	$TextBox/Label.text = text
	$TextBox.visible = true

func hide_text():
	$TextBox.visible = false

func _on_TextTime_timeout():
	hide_text()
