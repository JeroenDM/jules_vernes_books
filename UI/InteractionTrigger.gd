extends Area2D

export(String) var message = "Replace this text"
export(bool) var show_only_once = true
export(bool) var pause_while_message = true
var shown = false


func _on_InteractionTrigger_body_entered(body):
	if !shown:
		HUDInfo.message = message
		if pause_while_message:
			HUDInfo.toggle_pause()
		if show_only_once:
			shown = true
