extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("flag in contact with " + body.name)
	if body.name == "TileMap":
		pass
	if body.name == "Player": 
		GameManager.player_touching_flag()
