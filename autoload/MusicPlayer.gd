extends Node

onready var intro : AudioStreamPlayer = $Intro
onready var background_music : AudioStreamPlayer = $BackgroundMusic

func _ready() -> void:
	intro.play()

func play_loop():
	background_music.play()
