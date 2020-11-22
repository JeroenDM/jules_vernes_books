extends Area2D

var DEFAULTS = {'message': '', 
				'health': 0,
				'strength': 0,
				'solid': false,
				'add_drill': true}
var OBJECTS = {"Heart": {'message': 'You have collected a heart.', 'health': 10}, 
			   "Drill": {'message': 'You have collected a drill. You can use it using the space bar and the arrow keys.', 'add_drill': true}}
					
export var object_type = 'Heart'


func _ready():
	$Heart.visible = false
	$Drill.visible = false
	
	match object_type:
		'Heart':
			$Heart.visible = true
		'Drill':
			$Drill.visible = true

func get_prop(type, prop):
	if !OBJECTS.has(type):
		OBJECTS[type] = {}
	if !OBJECTS[type].has(prop):
		OBJECTS[type][prop] = DEFAULTS[prop]
	return OBJECTS[type][prop]

func set_prop(type, prop, value):
	if !OBJECTS.has(type):
		OBJECTS[type] = {}
	OBJECTS[type][prop] = value

func _on_ObjectsInteract_body_entered(body):
	var add_drill = get_prop(object_type, 'add_drill')
	if add_drill:
		PlayerData.can_drill = true
		
	var health = get_prop(object_type, 'health')
	PlayerData.health += health
	
	HUDInfo.set_message(get_prop(object_type, 'message'), 2)
	self.queue_free()
