extends RigidBody2D

var is_colliding := false

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if not is_colliding:
		if state.get_contact_count() > 0:
			PlayerData.health -= 1
			is_colliding = true
	else:
		if state.get_contact_count() == 0:
			is_colliding = false
