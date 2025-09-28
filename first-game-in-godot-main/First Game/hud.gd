extends Control
class_name HUD

@export var coin_label : Label
@export var corpse_count_label : Label

func update_coin_label(number: int):
	coin_label.text = "x " + str(number)

func update_corpse_count_label(number: int):
	corpse_count_label.text = "x " + str(number)
