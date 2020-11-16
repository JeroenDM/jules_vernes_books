extends Node

var max_health = 10
var health = max_health
var max_fuel = 10
var fuel = max_fuel

signal update_health
signal bleed
signal update_fuel

func add_health(value):
	health = clamp(0, health + value, max_health)
	print(health)
	emit_signal('update_health', health)

func remove_health(value):
	health = clamp(0, health - value, max_health)
	emit_signal('update_health', health)
	emit_signal('bleed')

func add_fuel(value):
	fuel = clamp(0, fuel + value, max_fuel)
	emit_signal('update_fuel', health)
	
func remove_fuel(value):
	fuel = clamp(0, fuel - value, max_fuel)
	emit_signal('update_fuel', health)
