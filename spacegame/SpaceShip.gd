extends RigidBody2D

export (float) var engine_thrust := 500.0
export (float) var spin_thrust := 2500.0

onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

var thrust: = Vector2.ZERO
var rotation_dir: = 0

func get_input() -> void:
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
		if audio_player.playing == false:
			audio_player.play()
	else:
		audio_player.stop()
		thrust = Vector2.ZERO
	
	rotation_dir = 0
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	
	if Input.is_action_just_pressed("ui_accept"):
		$Explosion.boom()

func _process(delta: float) -> void:
	get_input()
	
func _physics_process(delta: float) -> void:
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_dir * spin_thrust)
