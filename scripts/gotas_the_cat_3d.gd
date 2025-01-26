extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

var health: int = 3 # Example initial health

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func take_damage(amount: int) -> void:
	var escenaActual = get_tree().current_scene
	print("el jugador perdió salud en: ", escenaActual)
	
	GameoverRespawner.setSpawnScene(escenaActual)
	
	health -= amount
	print("salud: ", health)
	
	if health <= 0:
		die()
		
func die() -> void:
	var escenaActual = get_tree().current_scene
	
	print("el jugador murió en: ", escenaActual)
	GameoverRespawner.setSpawnScene(escenaActual)
	GameoverRespawner.precallGameOver()
	
	
