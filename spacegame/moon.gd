extends Sprite

export(String, FILE) var next_scene_path: = ""

func _on_Area2D_body_entered(body: Node) -> void:
	get_tree().change_scene(next_scene_path)
