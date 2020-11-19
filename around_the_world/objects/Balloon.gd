extends RigidBody2D

export (float) var engine_thrust := 200.0
export (float) var propeller_thrust := 200.0
export (float) var impact_multiplier := 0.2
export (float) var impact_threshold := 0.2
# use a curve instead of just a multiplier for the impact?
# low values should to damage, but high values not extremely more

var thrust := Vector2.ZERO
var direction := 0

onready var message_timer : Timer = $MessageTimer
onready var fuel_empty_message : Label = $OutOfFuelMessage

func _ready() -> void:
	PlayerData.connect("fuel_empty", self, "die")

func die() -> void:
	print("Out of fuel")
	fuel_empty_message.visible = true
	message_timer.start()
	engine_thrust = 0.0
	propeller_thrust = 0.0

func restart() -> void:
	fuel_empty_message.visible = false
	PlayerData.fuel = PlayerData.max_fuel
	PlayerData.health = PlayerData.max_health
	get_tree().reload_current_scene()

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


#func _physics_process(_delta: float) -> void:
#	set_applied_force(thrust)
#	set_applied_torque(0.1 * rotation)

var is_colliding := false

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	set_applied_force(thrust)
	
	if state.get_contact_count() > 0:
		if not is_colliding:
			is_colliding = true
			var impact = linear_velocity.length() * impact_multiplier
			if impact > impact_threshold:
				PlayerData.health -= impact
			print("collision", impact)
	else:
		is_colliding = false


func _on_food_detector_body_entered(body: Node) -> void:
	$food_detector/CollisionShape2D.disabled = true
	body.queue_free()
	PlayerData.fuel += 10
	$food_detector/CollisionShape2D.disabled = false
