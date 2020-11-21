extends Area2D

export(String, MULTILINE) var message = "Replace this text"
export(int) var message_duration = 3
export(bool) var show_only_once = true
export(bool) var pause_while_message = false
var shown = false


func _on_InteractionTrigger_body_entered(body):
	if !shown:
		HUDInfo.set_message(message, message_duration, pause_while_message)
		if show_only_once:
			shown = true
