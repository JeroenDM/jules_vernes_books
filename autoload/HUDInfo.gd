extends Node

var message := "Dummy message" setget set_message

signal update_message
signal set_paused

func set_message(value, time = 3, pause = false):
	message = value
	emit_signal('update_message', message, time, pause)

func set_paused(value):
	emit_signal('set_paused', value)
