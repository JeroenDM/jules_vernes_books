extends Node2D

export(int) var max_tile_strength = 1 # seconds
var max_properties = {'strength': max_tile_strength,
					  'solid': false,
					 }
var tile_properties = {}


func get_prop(prop, pos):
	if !tile_properties.has(pos):
		tile_properties[pos] = {}
		
	if !tile_properties[pos].has(prop):
		tile_properties[pos][prop] = max_properties[prop]
		
	return tile_properties[pos][prop]

func set_prop(prop, pos, value):
	get_prop(prop, pos) # initialise
	
	tile_properties[pos][prop] = max(0, value)
	
func reduce_prop(prop, pos, value):
	set_prop(prop, pos, get_prop(prop, pos) - value)
	
func get_strength(pos):
	return get_prop('strength', pos)

func set_strength(pos, value):
	set_prop('strength', pos, value)
	
func reduce_strength(pos, value):
	reduce_prop('strength', pos, value)

func _on_Player_collided(collision, time):
	var target = collision.collider
	if target is TileMap:
		var tile_pos = target.world_to_map($Player.position)
		
		tile_pos -= collision.normal
		
		reduce_strength(tile_pos, time)
		
		var strength = get_strength(tile_pos)
		var solid = get_prop('solid', tile_pos)
		if strength < max_tile_strength and !solid:
			$Cracks.set_cellv(tile_pos, floor((1-strength/max_tile_strength)*4))
			
			if strength == 0:
				# remove ground tile
				$Cracks.set_cellv(tile_pos, -1)
				target.set_cellv(tile_pos, -1)
				target.update_bitmask_area(tile_pos)
				
				# spawn other tile //TODO//
				var object = randi() % 10
				object = -1
				$HiddenObjects.set_cellv(tile_pos, object)
		
		if solid:
			$CanvasLayer/HUD.show_text('This rock is too hard!', 2)
