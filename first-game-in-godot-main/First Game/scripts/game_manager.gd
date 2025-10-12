extends Node

@onready var player = get_node("../Player")

var coins = 0
var corpse = 0
var hud = HUD
var current_area = 1
var health = 3
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
			get_tree().change_scene_to_file(path)
			print("change level to level " + str(current_area) )

func take_damage():
	if health > 1:
		health -= 1
		player.reset_position()
		hud.did_take_damage()
	else:
		get_tree().reload_current_scene()
		player.get_node("CollisionShape2D").queue_free()
