extends RigidBody2D

signal max_food_changed(new_max)
signal food_changed(new_food)
signal all_food_gone()

export (float) var engine_thrust = 200.0
export (float) var propeller_thrust = 200.0
export (int) var max_food = 10  setget set_max_food

var _food : int = max_food setget set_food
var thrust := Vector2.ZERO
var direction := 0

func _ready() -> void:
	emit_signal("max_food_changed", max_food)
	emit_signal("food_changed", floor(max_food / 2))
	
func set_max_food(new_value : int) -> void:
	max_food = max(1, new_value)
	emit_signal("max_food_changed", max_food)

func set_food(new_value : int) -> void:
	_food = clamp(new_value, 0, max_food)
	emit_signal("food_changed", _food)
	
	if _food == 0:
		emit_signal("all_food_gone")

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
	
	if Input.is_action_just_pressed("debug_1"):
		set_food(_food + 1)
	if Input.is_action_just_pressed("debug_2"):
		set_food(_food - 1)

func _process(delta: float) -> void:
	get_input()

func _physics_process(delta: float) -> void:
	set_applied_force(thrust)
	
	set_applied_torque(0.1 * rotation)

func _on_food_detector_body_entered(body: Node) -> void:
	# TODO get's called too much, food increases by a lot
	set_food(_food + 1)
	body.queue_free()
