extends Timer

export (float) var fuel_reduction = 1.2

func _ready() -> void:
	LevelData.time = 0
	start()

func _on_LevelTimer_timeout():
	LevelData.time += 1
	PlayerData.fuel -= fuel_reduction
	print(LevelData.time)
