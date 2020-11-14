extends RigidBody2D

export (float) var engine_thrust = 200.0
export (float) var propeller_thrust = 200.0

var thrust := Vector2.ZERO
var direction := 0

func _ready() -> void:
	pass
	
func get_input() -> void:
	if Input.is_action_pressed("ui_up"):
		thrust.y = -engine_thrust
	else:
		thrust.y = 0.0
	
	direction = 0
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1
	thrust.x = direction * propeller_thrust

func _process(delta: float) -> void:
	get_input()

func _physics_process(delta: float) -> void:
	set_applied_force(thrust)
