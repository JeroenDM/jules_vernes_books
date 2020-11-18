extends Button

export(String, FILE) var next_scene_path: = ""

func _on_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene(next_scene_path)
