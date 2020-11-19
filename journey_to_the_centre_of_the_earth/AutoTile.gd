extends Node2D

export(int) var max_tile_strength = 1 # seconds
var max_properties = {'default': {'strength': 0, 'solid': false,
								  'message': '', 'health': 0, 'add_drill': false},
					  'tile': {'strength': max_tile_strength}, 
					  -1: {},
					  0: {'solid': true},
					  1: {'message': 'You have collected a ladder'},
					  2: {'message': 'You have collected food'},
					  3: {'message': 'You have collected explosives'},
					  4: {'message': 'You have collected a platform'},
					  5: {'message': 'You have collected a map'},
					  6: {'message': 'You have collected something else entirely'},
					  7: {'message': 'You have collected health', 'health': 10},
					  8: {'message': 'You have collected health', 'add_drill': true},
					 }
var tile_properties = {}
var object_properties = {}

onready var player_data = get_node("/root/PlayerData")


func _ready():
	player_data.connect('update_health', $CanvasLayer/HUD, 'set_health')
	player_data.connect('update_fuel', $CanvasLayer/HUD, 'set_fuel')
	player_data.connect('bleed', $CanvasLayer/HUD, 'bleed')


func get_properties(type):
	var properties
	if str(type) == 'tile':
		properties = tile_properties
	else:
		properties = object_properties
	return properties
	
func get_prop(type, prop, pos):
	var properties = get_properties(type)
	
	if !properties.has(pos):
		properties[pos] = {}
		
	if !properties[pos].has(prop):
		var prop_tmp = max_properties['default'][prop]
		if max_properties[type].has(prop):
			prop_tmp = max_properties[type][prop]
		
		properties[pos][prop] = prop_tmp
		
	return properties[pos][prop]

func set_prop(type, prop, pos, value):
	get_prop(type, prop, pos) # initialise
	
	var properties = get_properties(type)
	properties[pos][prop] = max(0, value)

func rm_prop(type, pos):
	var properties = get_properties(type)
	properties.erase(pos)
	
func reduce_prop(type, prop, pos, value):
	set_prop(type, prop, pos, get_prop(type, prop, pos) - value)
	
func get_strength(type, pos):
	return get_prop(type, 'strength', pos)

func set_strength(type, pos, value):
	set_prop(type, 'strength', pos, value)
	
func reduce_strength(type, pos, value):
	reduce_prop(type, 'strength', pos, value)
	
func _on_Player_interact(collision, time):
	var target = collision.collider
	if target.name == 'Ground':
		var tile_pos = target.world_to_map($Player.position)
		
		tile_pos -= collision.normal
		
		reduce_strength('tile', tile_pos, time)
		
		var strength = get_strength('tile', tile_pos)
		var solid = get_prop('tile', 'solid', tile_pos)
		if strength < max_tile_strength and !solid:
			$Cracks.set_cellv(tile_pos, floor((1-strength/max_tile_strength)*4))
			
			if strength == 0:
				# remove ground tile
				$Cracks.set_cellv(tile_pos, -1)
				target.set_cellv(tile_pos, -1)
				target.update_bitmask_area(tile_pos)
				rm_prop('tile', tile_pos)
				
				# spawn other tile
#				var object = randi() % 6
#				$Objects.set_cellv(tile_pos, object)
		elif solid:
			$CanvasLayer/HUD.show_text('This rock is too hard!', 2)
	elif target.name == 'Objects':
		var tile_pos = $Ground.world_to_map($Player.position)
		
		tile_pos -= collision.normal
		tile_pos = Functions.round_vector(tile_pos)
		var type = $Objects.get_cellv(tile_pos)
		
		reduce_strength(type, tile_pos, time)
		
		var strength = get_strength(type, tile_pos)
		var health = get_prop(type, 'health', tile_pos)
		PlayerData.health += health
		var solid = get_prop(type, 'solid', tile_pos)
		if strength < max_tile_strength and !solid:
			if strength == 0:
				# remove ground tile
				$Objects.set_cellv(tile_pos, -1)
				$CanvasLayer/HUD.show_text(get_prop(type, 'message', tile_pos), 2)
		elif solid:
			$CanvasLayer/HUD.show_text('This rock is too hard!', 2)
