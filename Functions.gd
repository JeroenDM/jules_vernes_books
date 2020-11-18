extends Node

static func is_parallel(vec1: Vector2, vec2: Vector2) -> bool:
	var dot_prod = stepify(vec1.normalized().dot(vec2.normalized()), 0.1)
	return dot_prod == 1

static func round_vector(vec: Vector2) -> Vector2:
	return Vector2(round(vec.x), round(vec.y))
