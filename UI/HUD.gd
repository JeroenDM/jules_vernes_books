extends Control

export(bool) var enable_food_bar = true
export(bool) var enable_timer = true
export(Color, RGBA) var bleed_color = Color(1, 0, 0, 1)

# cache sceen tree for efficiency
onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = $PauseOverlay
onready var food_bar : ProgressBar = $FoodBar
onready var health_bar : ProgressBar = $HealthBar

var paused := false setget set_paused
var menu := false setget set_menu
var text_time = 3

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
		if !PlayerData.die:
			toggle_game_menu()
	
	if event.is_action_pressed("ui_accept"):
		if $TextBox/Label.get_visible_characters() == ($TextBox/Label.get_total_character_count() + 1):
			hide_text()
			$TextTime.stop()
		else:
			$TextBox/Label.set_visible_characters($TextBox/Label.get_total_character_count() + 1)
		
func toggle_game_pause() -> void:
	self.paused = not paused
	
func toggle_game_menu() -> void:
	self.menu = not menu
	self.paused = menu
	show_menu()

func show_menu():
	if menu:
		if PlayerData.die:
			$PauseOverlay/Title.text = "Game Over!"
		else:
			$PauseOverlay/Title.text = "Game Paused"
		pause_overlay.visible = true
	else:
		pause_overlay.visible = false

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	scene_tree.set_input_as_handled()

func set_menu(value: bool) -> void:
	menu = value

func update_fuel(value : float) -> void:
	food_bar.set_value(PlayerData.fuel)

func update_health(value : int) -> void:
	health_bar.set_value(PlayerData.health)
	
func bleed() -> void:
	$AnimationPlayer.play("bleed_animation")

func update_time():
	$LevelTimer.text = "Time: %d" % LevelData.time

func update_message(text, time = 3, pause = false):
	text_time = time
	$TextBox/Label.text = text
	$TextBox/Label.set_visible_characters(0)
	$TextBox.visible = true
	$LetterTime.start(0.03)
	if pause:
		set_paused(true)

func show_text(text, time = 3):
	update_message(text, time)

func hide_text():
	$TextBox.visible = false
	if !menu:
		set_paused(false)

func _on_LetterTime_timeout():
	if $TextBox/Label.get_visible_characters() == $TextBox/Label.get_total_character_count():
		$TextTime.start(text_time)
		$TextBox/Label.set_visible_characters($TextBox/Label.get_visible_characters() + 1)
	elif $TextBox/Label.get_visible_characters() < $TextBox/Label.get_total_character_count():
		$TextBox/Label.set_visible_characters($TextBox/Label.get_visible_characters() + 1)

func _on_TextTime_timeout():
	hide_text()

