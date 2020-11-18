extends Control

#func _on_StartGameButton_pressed():
#	get_tree().change_scene("res://around_the_world/levels/World.tscn")
#
#
#func _on_QuitGameButton_pressed():
#	get_tree().quit()
#
#
#func _on_Level1_pressed():
#	get_tree().change_scene("res://journey_to_the_centre_of_the_earth/Level1.tscn")


func _on_ToTheCentre_pressed() -> void:
	get_tree().change_scene("res://journey_to_the_centre_of_the_earth/Level1.tscn")


func _on_AroundTheWorld_pressed() -> void:
	get_tree().change_scene("res://around_the_world/levels/World.tscn")


func _on_ToTheMoon_pressed() -> void:
	pass # Replace with function body.
