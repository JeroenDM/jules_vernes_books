extends KinematicBody2D

var _picked := false
var hook : KinematicBody2D
var body_copied := false

func _process(delta: float) -> void:
	if _picked:
		position = hook.global_position
		print(hook.position)
	


func _on_hook_detector_body_entered(body: KinematicBody2D) -> void:
	_picked = true
	if not body_copied:
		hook = body
		body_copied = true
