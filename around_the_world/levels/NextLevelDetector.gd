extends Area2D

export(String, FILE) var next_scene_path: = ""

func _on_body_entered(body):
	get_tree().change_scene(next_scene_path)
