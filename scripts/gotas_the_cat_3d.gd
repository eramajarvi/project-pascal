extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

@onready var raycast: RayCast3D = $RayCast3D

var health: int = 3 # Vida inicial del personaje

func _physics_process(delta: float) -> void:
	# Aplicar gravedad.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Manejar salto.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Obtener dirección del RayCast3D.
	var ray_direction := (raycast.target_position).normalized()

	# Obtener entrada del jugador y ajustar dirección según el RayCast3D.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Vector3(
		input_dir.x * ray_direction.x - input_dir.y * ray_direction.z, # Ejes X y Z adaptados al RayCast
		0,
		input_dir.x * ray_direction.z + input_dir.y * ray_direction.x
	).normalized()

	# Actualizar velocidad según dirección.
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Mover al personaje.
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
	
	
