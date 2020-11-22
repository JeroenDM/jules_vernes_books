extends HBoxContainer

func _ready():
	PlayerData.connect("level_2_unlocked", self, "unlock_level_2")
	PlayerData.connect("level_3_unlocked", self, "unlock_level_3")

func unlock_level_2():
	$Book1.unlock()

func unlock_level_3():
	$Book2.unlock()
