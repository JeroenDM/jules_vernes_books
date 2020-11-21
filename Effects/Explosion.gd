extends Node2D

func boom() -> void:
	print("BOOM!")
	$Particles2D.set_emitting(true)
