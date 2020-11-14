extends Control



func _on_StartGameButton_pressed():
	get_tree().change_scene("res://around_the_world/levels/World.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()
