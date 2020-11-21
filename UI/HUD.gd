extends Control

export(bool) var enable_food_bar = true
export(bool) var enable_timer = true

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
	
	PlayerData.connect("health_changed", self, "update_health")
	PlayerData.connect("fuel_changed", self, "update_fuel")
	PlayerData.connect("bleed", self, "bleed")
	LevelData.connect("time_changed", self, "update_time")
	HUDInfo.connect("update_message", self, "update_message")
	HUDInfo.connect("set_paused", self, "set_paused")
	
	health_bar.set_max(PlayerData.max_health)
	food_bar.set_max(PlayerData.max_fuel)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		print("input paused: ")
		toggle_game_pause()
		toggle_game_menu()
		
func toggle_game_pause() -> void:
	self.paused = not paused
	
func toggle_game_menu() -> void:
	pause_overlay.visible = paused

func set_paused(value: bool) -> void:
	print('Pause: ', value)
	paused = value
	scene_tree.paused = value
	scene_tree.set_input_as_handled()

func update_fuel(value : float) -> void:
	food_bar.set_value(PlayerData.fuel)

func update_health(value : int) -> void:
	health_bar.set_value(PlayerData.health)
	
func bleed() -> void:
	$Panel.visible = true
	$BleedTimer.start()

func stop_bleeding() -> void:
	$Panel.visible = false

func update_time():
	$LevelTimer.text = "Time: %d" % LevelData.time

func update_message(text, time = 3, pause = false):
	$TextTime.start(time)
	$TextBox/Label.text = text
	$TextBox.visible = true
	if pause:
		set_paused(true)

func show_text(text, time = 3):
	update_message(text, time)

func hide_text():
	$TextBox.visible = false
	set_paused(false)

func _on_TextTime_timeout():
	hide_text()
