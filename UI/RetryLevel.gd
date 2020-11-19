extends Button

func _on_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	get_tree().reload_current_scene()
