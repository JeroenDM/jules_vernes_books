extends TileMap


func _on_Player_collided(collision):
	var target = collision.collider
	if target is TileMap:
		var tile_pos = target.world_to_map(get_node("../Player").position)
		print(target.name)
		print(tile_pos)
		tile_pos -= collision.normal
		print(tile_pos)
		target.set_cellv(tile_pos, -1)
		target.update_bitmask_area(tile_pos)
		
