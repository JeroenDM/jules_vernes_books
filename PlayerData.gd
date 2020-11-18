extends Node

# also make these adjustable with setters?
# they can already be changed, because they are not const
var max_health := 10.0
var max_fuel := 10.0

signal health_changed
signal fuel_changed
signal bleed # move this to the player ?

var health := max_health setget set_health
var fuel := max_fuel setget set_fuel


func set_health(value : float) -> void:
	if value < health:
		emit_signal('bleed')
	health = clamp(value, 0, max_health)
	emit_signal('health_changed', health)


func set_fuel(value: float) -> void:
	fuel = clamp(value, 0, max_fuel)
	emit_signal('fuel_changed', health)
