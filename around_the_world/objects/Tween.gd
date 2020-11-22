extends Tween

onready var parent : = get_parent()

func _ready():
	interpolate_property(
		parent,
		"scale",
		Vector2.ZERO,
		parent.get_scale(),
		0.9,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	start()
