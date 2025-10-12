extends Area2D

@onready var timer = $Timer
@onready var animation = $AnimationPlayer

var player = null

func _on_body_entered(body):
	if body.name == "Player":
		player = body
		if GameManager.health > 1:
			GameManager.take_damage(player)
		else:
			timer.start()
			animation.play("PlayDeath")


func _on_timer_timeout():
	Engine.time_scale = 1.0
	GameManager.take_damage(player)
