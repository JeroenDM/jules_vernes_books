extends Node2D

export(String, FILE) var next_scene_path: = ""

func _ready() -> void:
	$LaunchTimer.start()


func _on_LaunchTimer_timeout() -> void:
	$AnimationPlayer.play("launch")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene(next_scene_path)
