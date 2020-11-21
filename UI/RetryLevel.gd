extends Button

func _on_pressed() -> void:
	PlayerData.health = PlayerData.max_health
	PlayerData.fuel = PlayerData.max_fuel
	if get_tree().paused:
		get_tree().paused = false
	get_tree().reload_current_scene()
