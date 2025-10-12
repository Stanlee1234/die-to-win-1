extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(body: Node2D) -> void:
	print("flag in contact with " + body.name)
	if body.name == "TileMap":
		pass
	if body.name == "Player": 
		game_manager.player_touching_flag()
