extends Node2D

export (float) var speed := 300.0

var _whiching := false
var _length := 16.0

func _process(delta: float) -> void:
	get_input()
	
	if _whiching:
		_length += speed * delta
	else:
		_length = max(0.0, _length - speed * delta)
	
	$texture.rect_size.y = _length
	$hook.position.y = _length
	global_rotation = 0.0
	
	

func get_input() -> void:
	if Input.is_action_pressed("wich_out"):
		_whiching = true
	else:
		_whiching = false
