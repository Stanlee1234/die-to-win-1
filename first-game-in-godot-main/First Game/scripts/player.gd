#Hey... Wait a minute! Your not supposed to be here!!! GET OUT
extends CharacterBody2D
class_name Player


const SPEED = 90.0
const JUMP_VELOCITY = -260.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var corpse_counter = 0
var is_sacrifice = false
var spawnpoint = Vector2(self.position.x, self.position.y)
var jump_timer = 0.0
var was_on_floor = false
var can_jump_anyway = false

@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if is_sacrifice:
		return
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump"):
		jump_timer = 0.1
	jump_timer -= delta
	# Handle jump.
	if was_on_floor and is_on_floor():
		$CoyoteTimer.start(0.1)
		can_jump_anyway = true
	if jump_timer > 0 and (is_on_floor() or can_jump_anyway):
		velocity.y = JUMP_VELOCITY
		was_on_floor = false
	else:
		was_on_floor = true
	if Input.is_action_just_pressed("reset"):
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor() :
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	process_sacrifice()

func create_duplicate_sprite():
	if not is_sacrifice:
		return
	var corpse = StaticBody2D.new()
	var new_sprite = animated_sprite.duplicate()
	var collision_shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(11,5)
	collision_shape.position = Vector2(3,0)
	collision_shape.shape = rect
	corpse.add_child(collision_shape)
	corpse.add_child(new_sprite)
	
	
	is_sacrifice = false
	corpse_counter += 1
	add_sibling(corpse)
	corpse.position = Vector2(self.position.x, self.position.y)
	corpse.name = "corpse" + str(corpse_counter)	
	GameManager.add_corpse_count()
	reset_position()
	
	
func process_sacrifice():
	if Input.is_action_just_pressed("sacrifice"):
		animated_sprite.animation_finished.connect(create_duplicate_sprite)
		is_sacrifice = true
		animated_sprite.play("sacrifice")
		
func _on_body_entered(body: Node2D):
	print(body.name)

func reset_position():
	self.position = spawnpoint
	self.velocity = Vector2(0,0)

func _on_coyote_timer_timeout() -> void:
	can_jump_anyway = false
