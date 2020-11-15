extends TileMap

export(int) var max_tile_strength = 1 # seconds
var tile_properties = {}


func get_strength(pos):
	if !tile_properties.has(pos):
		tile_properties[pos] = {}
		
	if !tile_properties[pos].has('strength'):
		tile_properties[pos]['strength'] = max_tile_strength
	
	print(tile_properties[pos]['strength'])
	return tile_properties[pos]['strength']

func set_strength(pos, value):
	get_strength(pos) # initialise
	
	tile_properties[pos]['strength'] = max(0, value)
	
func reduce_strength(pos, value):
	set_strength(pos, get_strength(pos) - value)


func _on_Player_collided(collision, time):
	var target = collision.collider
	if target is TileMap:
		var tile_pos = target.world_to_map(get_node("../Player").position)
		
		tile_pos -= collision.normal
		
		reduce_strength(tile_pos, time)
		
		var strength = get_strength(tile_pos)
		if strength == 0:
			target.set_cellv(tile_pos, -1)
			target.update_bitmask_area(tile_pos)
