extends Node

var coins = 0
var corpse = 0
var current_area = 3
var health = 3
var area_path = "res://Area/"
var totalcorpse = 0

func _ready():
	AudioPlayer.play_music_level()

func add_coin():
	coins += 1


func add_corpse_count():
	corpse += 1

func player_touching_flag():
	if coins == 10:
		current_area += 1
		var path = "res://Area/level_" + str(current_area) + ".tscn"
		get_tree().change_scene_to_file(path)
		print("change level to level " + str(current_area) )
		totalcorpse += corpse
		reset()


func take_damage(player):
	if health > 1:
		health -= 1
		player.reset_position()
	else:
		get_tree().reload_current_scene()
		reset()

func reset():
	coins = 0
	health = 3
	corpse = 0
