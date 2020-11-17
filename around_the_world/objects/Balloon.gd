extends RigidBody2D

export (float) var engine_thrust = 200.0
export (float) var propeller_thrust = 200.0

var thrust := Vector2.ZERO
var direction := 0


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
		PlayerData.fuel += 1
	if Input.is_action_just_pressed("debug_2"):
		PlayerData.fuel -= 1
	if Input.is_action_just_pressed("debug_3"):
		PlayerData.health += 1
	if Input.is_action_just_pressed("debug_4"):
		PlayerData.health -= 1


func _process(_delta: float) -> void:
	get_input()


func _physics_process(_delta: float) -> void:
	set_applied_force(thrust)
	set_applied_torque(0.1 * rotation)


func _on_food_detector_body_entered(body: Node) -> void:
	$food_detector/CollisionShape2D.disabled = true
	body.queue_free()
	PlayerData.fuel += 1
	$food_detector/CollisionShape2D.disabled = false
