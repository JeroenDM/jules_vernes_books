extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const MAX_SPEED = 300
const ACCELERATION = 50
const JUMP_HEIGHT = -650

var motion = Vector2()
var last_direction = Vector2()
var health = 10
signal interact

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	# move
	if Input.is_action_pressed("ui_right"):
		last_direction = Vector2.RIGHT
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		last_direction = Vector2.LEFT
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			last_direction = Vector2.UP
			motion.y = JUMP_HEIGHT
		if Input.is_action_pressed("ui_down"):
			last_direction = Vector2.DOWN
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			last_direction = Vector2.UP
			$Sprite.play("Jump")
		else:
			last_direction = Vector2.DOWN
			$Sprite.play("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	var impact = motion.y/100
	motion = move_and_slide(motion, UP)
	if is_on_floor() and impact > 9:
		var damage = round(max(impact-9,0))
		PlayerData.health -= damage
	
	# drill
	if Input.is_action_pressed("ui_accept"):
		$Sprite.play("Drill")
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision:
				if Functions.is_parallel(collision.normal, -last_direction):
					print('Success')
					emit_signal('interact', collision, delta)
		
