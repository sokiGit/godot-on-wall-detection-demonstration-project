class_name PlayerBody3D extends CharacterBody3D


@export var wall_shapecast: ShapeCast3D;

const WALK_SPEED = 5.0
const JUMP_VELOCITY = 4.5

enum State {
	Floor,
	Wall,
	Air,
}

signal state_signal(State)

var currentState = State.Air;

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# handle jump
	if Input.is_action_just_pressed("move_jump") && currentState == State.Floor:
		velocity.y = JUMP_VELOCITY

	# handle input direction
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * WALK_SPEED
		velocity.z = direction.z * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)

	# handle state
	if custom_is_on_wall_only():
		currentState = State.Wall
	elif is_on_floor():
		currentState = State.Floor
	else:
		currentState = State.Air

	state_signal.emit(currentState)
	
	move_and_slide()

func custom_is_on_wall() -> bool:
	return wall_shapecast.is_colliding();


func custom_is_on_wall_only() -> bool:
	return !is_on_floor() and !is_on_ceiling() and custom_is_on_wall()
