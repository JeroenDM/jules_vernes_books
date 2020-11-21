extends Node

var message := "Dummy message" setget set_message

signal update_message
signal toggle_pause

func set_message(value):
	message = value
	emit_signal('update_message', message)

func toggle_pause():
	emit_signal('toggle_pause')
