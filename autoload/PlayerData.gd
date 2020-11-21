extends Node

# also make these adjustable with setters?
# they can already be changed, because they are not const
var max_health := 10.0
var max_fuel := 10.0

signal health_changed
signal fuel_changed
signal bleed # move this to the player ?
signal die
signal fuel_empty

var health := max_health setget set_health
var fuel := max_fuel setget set_fuel
var can_drill := false setget set_drill


func set_health(value : float, bleed: bool = true) -> void:
	if value < health and bleed:
		emit_signal('bleed')
	health = clamp(value, 0, max_health)
	emit_signal('health_changed', health)
	if health == 0:
		emit_signal('die')


func set_fuel(value: float) -> void:
	fuel = clamp(value, 0.0, max_fuel)
	emit_signal('fuel_changed', health)
	if fuel == 0.0:
		emit_signal("fuel_empty")

func set_drill(value: bool) -> void:
	can_drill = value
