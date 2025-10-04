extends CharacterBody2D

# --- Editable in the editor ---
@export var speed: float = 200.0           # Horizontal movement speed
@export var jump_velocity: float = 400.0   # How high the player jumps
@export var gravity: float = 900.0         # Gravity applied every second

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	# --- Horizontal Input ---
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1

	# Normalize horizontal input (not strictly needed for 1D horizontal movement)
	input_vector = input_vector.normalized()
	velocity.x = input_vector.x * speed

	# --- Apply Gravity ---
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Allow jumping only when on the floor
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_velocity

	# --- Move the character ---
	move_and_slide()
