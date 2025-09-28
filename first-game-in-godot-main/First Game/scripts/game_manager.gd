extends Node

@onready var score_label = $ScoreLabel
var coins = 0
var corpse = 0
var hud = HUD

func _ready():
	hud = get_tree().get_first_node_in_group("hud")

func add_coin():
	coins += 1
	hud.update_coin_label(coins)

func add_corpse_count():
	corpse += 1
	hud.update_corpse_count_label(corpse)
