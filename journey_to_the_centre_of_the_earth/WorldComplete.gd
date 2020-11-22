extends Area2D

export(String, FILE, "*.tscn") var next_world
export(String) var next_level_name = "Book2"

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			PlayerData.level_locks[next_level_name] = false
			get_tree().change_scene(next_world)
