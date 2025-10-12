extends Label

func _process(delta: float) -> void:
	self.text = "Awesome job! You finished the game with " + str(GameManager.totalcorpse) + " Corpses!

Thank you for playing Die to Win!"
