extends Node

@onready var score_label = $ScoreLabel
var coins = 0
var corpse = 0
var hud = HUD
var current_area = 1
var area_path = "res://Area/"

func next_level():
	current_area += 1
	var full_path = area_path + "area_" + str(current_area) + ".tscn"
	get_tree().change_scene_to_file(full_path)

func _ready():
	AudioPlayer.play_music_level()
	hud = get_tree().get_first_node_in_group("hud")

func add_coin():
	coins += 1
	hud.update_coin_label(coins)

func add_corpse_count():
	corpse += 1
	hud.update_corpse_count_label(corpse)
