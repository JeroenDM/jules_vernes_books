extends TextureButton

export (float) var darkener = 0.3
export(String, FILE) var next_scene_path: = ""
export(bool) var locked = true

func _ready():
	if PlayerData.level_locks[name]:
		lock()
	else:
		unlock()

func _on_mouse_entered() -> void:
	modulate.r -= darkener
	modulate.g -= darkener
	modulate.b -= darkener


func _on_mouse_exited() -> void:
	modulate.r += darkener
	modulate.g += darkener
	modulate.b += darkener


func _on_pressed() -> void:
	if not locked:
		get_tree().change_scene(next_scene_path)

func lock():
	locked = true
	self_modulate.r = 0.1
	self_modulate.g = 0.1
	self_modulate.b = 0.1
	$Label.visible = true

func unlock():
	locked = false
	self_modulate.r = 1.0
	self_modulate.g = 1.0
	self_modulate.b = 1.0
	$Label.visible = false
