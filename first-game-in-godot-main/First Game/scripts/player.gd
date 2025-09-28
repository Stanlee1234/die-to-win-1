extends CharacterBody2D


const SPEED = 90.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var corpse_counter = 0
var is_sacrifice = false
var spawnpoint = Vector2(self.position.x, self.position.y)



@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if is_sacrifice:
		return
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
	var corpse = Area2D.new()
	var new_sprite = animated_sprite.duplicate()
	var collision_shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = Vector2(15, 8)
	collision_shape.shape = rect
	corpse.add_child(collision_shape)
	corpse.add_child(new_sprite)
	
	
	is_sacrifice = false
	corpse_counter += 1
	add_sibling(corpse)
	corpse.position = Vector2(self.position.x, self.position.y)
	corpse.name = "corpse" + str(corpse_counter)
	self.position = spawnpoint
	self.velocity = Vector2(0,0)
	
func process_sacrifice():
	if Input.is_action_just_pressed("sacrifice"):
		animated_sprite.animation_finished.connect(create_duplicate_sprite)
		is_sacrifice = true
		animated_sprite.play("sacrifice")
