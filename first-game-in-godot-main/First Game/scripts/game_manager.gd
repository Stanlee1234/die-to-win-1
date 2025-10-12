extends Node

var coins = 0
var corpse = 0
var hud = HUD
var current_area = 1
var area_path = "res://Area/"

func _ready():
	AudioPlayer.play_music_level()
	hud = get_tree().get_first_node_in_group("hud")

func add_coin():
	coins += 1
	hud.update_coin_label(coins)


func add_corpse_count():
	corpse += 1
	hud.update_corpse_count_label(corpse)

func player_touching_flag():
	if coins == 10:
			current_area += 1
			var path = "res://Area/level_" + str(current_area) + ".tscn"
			LoadManager.load_scene(path)
			print("change level to level " + str(current_area) )
