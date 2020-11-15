extends Sprite

export (float) var min_speed = 10
export (float) var max_speed = 30

var speed : float
var max_x_position := 4000.0

func _ready() -> void:
	frame = randi() % 4
	speed = randf() * (max_speed - min_speed) + min_speed

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > max_x_position:
		position.x = -300
		frame = randi() % 4
