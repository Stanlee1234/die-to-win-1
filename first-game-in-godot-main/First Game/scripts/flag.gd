extends Area2D

var score = 0

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "TileMap":
		pass
	if body.name == "Player":
		var path = "res://Area/level_2.tscn"
		get_tree().change_scene_to_file(path)
		print("change level")
