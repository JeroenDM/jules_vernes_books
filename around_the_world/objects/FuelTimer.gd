extends Timer

export (float) var fuel_reduction = 1.2

func _ready() -> void:
	LevelData.time = 0
	start()

func decrease_fuel():
	LevelData.time += 1
	PlayerData.fuel -= fuel_reduction
