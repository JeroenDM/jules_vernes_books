extends Control

export(bool) var enable_food_bar = true
export(bool) var enable_timer = true
export(Color, RGBA) var bleed_color = Color(1, 0, 0, 1)

# cache sceen tree for efficiency
onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var food_bar : ProgressBar = $FoodBar
onready var health_bar : ProgressBar = $HealthBar

var paused: = false setget set_paused

func _ready():
	$FoodBar.visible = enable_food_bar
	$LevelTimer.visible = enable_timer
	$TextBox.visible = false
	$BleedPanel.modulate = bleed_color
	
	PlayerData.connect("health_changed", self, "update_health")
	PlayerData.connect("fuel_changed", self, "update_fuel")
	PlayerData.connect("bleed", self, "bleed")
	LevelData.connect("time_changed", self, "update_time")
	
	health_bar.set_max(PlayerData.max_health)
	food_bar.set_max(PlayerData.max_fuel)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		print("input paused: ")
		self.paused = not paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool) -> void:
	paused = value
	print("paused: ", value)
	scene_tree.paused = value
	pause_overlay.visible = value

func update_fuel(value : float) -> void:
	food_bar.set_value(PlayerData.fuel)

func update_health(value : int) -> void:
	health_bar.set_value(PlayerData.health)
	
func bleed() -> void:
	$AnimationPlayer.play("bleed_animation")


func update_time():
	$LevelTimer.text = "Time: %d" % LevelData.time


func show_text(text, time = 3):
	$TextTime.start(time)
	$TextBox/Label.text = text
	$TextBox.visible = true

func hide_text():
	$TextBox.visible = false

func _on_TextTime_timeout():
	hide_text()

