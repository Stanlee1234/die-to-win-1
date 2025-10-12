extends Area2D

@onready var timer = $Timer
@onready var animation = $AnimationPlayer
@onready var game_manager = %GameManager


func _on_body_entered(body):
	if body.name == "Player":
		animation.play("PlayDeath")
		timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	game_manager.take_damage()
