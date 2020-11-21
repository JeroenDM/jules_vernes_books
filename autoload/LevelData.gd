extends Node

signal time_changed

var time : int = 0 setget set_time

func set_time(t : int) -> void:
	time = t
	emit_signal("time_changed")
