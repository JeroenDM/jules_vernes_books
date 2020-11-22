extends RigidBody2D

export (float) var engine_thrust := 500.0
export (float) var spin_thrust := 2500.0

onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
onready var engine_fire : Particles2D = $rocket/Particles2D

var thrust: = Vector2.ZERO
var rotation_dir: = 0

func _ready():
	PlayerData.connect("die", self, "restart")
	PlayerData.health = PlayerData.max_health
	PlayerData.fuel = PlayerData.max_fuel

func restart():
	PlayerData.fuel = PlayerData.max_fuel
	PlayerData.health = PlayerData.max_health
	get_tree().reload_current_scene()

func get_input() -> void:
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(engine_thrust, 0)
		engine_fire.emitting = true
		if audio_player.playing == false:
			audio_player.play()
	else:
		thrust = Vector2.ZERO
		engine_fire.emitting = false
		audio_player.stop()
	
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
