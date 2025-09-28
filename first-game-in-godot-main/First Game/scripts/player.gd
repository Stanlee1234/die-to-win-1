extends CharacterBody2D


const SPEED = 90.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var corpse_counter = 0
var is_sacrifice = false


@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if not is_sacrifice:
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
	var new_sprite = animated_sprite.duplicate()
	is_sacrifice = false
	corpse_counter += 1
	add_sibling(new_sprite)
	new_sprite.position = Vector2(self.position.x, self.position.y - 6)
	new_sprite.name = "corpse" + str(corpse_counter)
	
func process_sacrifice():
	if Input.is_action_just_pressed("sacrifice"):
		animated_sprite.animation_finished.connect(create_duplicate_sprite)
		is_sacrifice = true
		animated_sprite.play("sacrifice")
