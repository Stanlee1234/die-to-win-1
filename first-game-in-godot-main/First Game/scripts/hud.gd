extends Control

@export var coin_label : Label
@export var corpse_count_label : Label

func _process(delta: float) -> void:
	coin_label.text = "x " + str(GameManager.coins)
	corpse_count_label.text = "x " + str(GameManager.corpse)
	$HeartLabel.frame = 3 - GameManager.health
