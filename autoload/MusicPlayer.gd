extends Node

onready var background_music : AudioStreamPlayer = $BackgroundMusic

func _ready() -> void:
	background_music.play()
