extends Node2D

export(String, FILE) var next_scene_path: = ""
export(String, MULTILINE) var message = ""

func _ready() -> void:
	$LaunchTimer.start()


func _on_LaunchTimer_timeout() -> void:
	HUDInfo.set_message(message, 3, true)
	$AnimationPlayer.play("launch")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	get_tree().change_scene(next_scene_path)
