extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const MAX_SPEED = 300
const ACCELERATION = 50
const JUMP_HEIGHT = -650

var motion = Vector2()
var health = 10
signal collided

onready var player_data = get_node("/root/PlayerData")

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	# move
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	var impact = motion.y/100
	motion = move_and_slide(motion, UP)
	if is_on_floor() and impact > 9:
		var damage = round(max(impact-9,0))
		print('damage')
		print(damage)
		player_data.remove_health(damage)
	
	# drill
	if Input.is_action_pressed("ui_accept"):
		$Sprite.play("Drill")
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision:
				emit_signal('collided', collision, delta)
		
