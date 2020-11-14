extends TileMap


func _on_Player_collided(collision):
	if collision.collider is TileMap:
		var tile_pos = collision.collider.world_to_map(get_node("../Player").position)
		print(collision.collider.name)
		print(tile_pos)
		tile_pos -= collision.normal
		print(tile_pos)
		collision.collider.set_cellv(tile_pos, -1)
