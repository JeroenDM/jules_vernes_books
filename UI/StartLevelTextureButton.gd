extends TextureButton

export (float) var darkener = 0.3
export(String, FILE) var next_scene_path: = ""

func _on_mouse_entered() -> void:
	modulate.r -= darkener
	modulate.g -= darkener
	modulate.b -= darkener


func _on_mouse_exited() -> void:
	modulate.r += darkener
	modulate.g += darkener
	modulate.b += darkener


func _on_pressed() -> void:
	get_tree().change_scene(next_scene_path)
