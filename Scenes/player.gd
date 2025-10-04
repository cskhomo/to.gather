extends CharacterBody2D

# Movement variables (editable in the editor)
@export var walk_speed : float = 200.0
@export var run_speed : float = 350.0
@export var jump_velocity : float = -400.0
@export var gravity : float = 800.0

func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		print("On floor! Ready to jump!")  # Debug line

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		print("Jumping!")  # Debug line
		velocity.y = jump_velocity

	# Get input direction
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Determine movement speed
	var current_speed = run_speed if Input.is_action_pressed("sprint") else walk_speed
	
	# Apply horizontal movement
	if input_dir != Vector2.ZERO:
		velocity.x = input_dir.x * current_speed
	else:
		# Apply friction when not moving
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()
