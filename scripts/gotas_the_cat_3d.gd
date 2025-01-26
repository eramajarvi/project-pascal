extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

const RAY_LENGTH = 1000
signal attack_door(target)

@onready var animation_player =  $AnimatedSprite3D
@onready var raycast: RayCast3D = $RayCast3D
@export var shadow_decal_scene: PackedScene

var health: int = 3 # Vida inicial del personaje

func _process(delta: float) -> void:
	# Instance the shadow decal
	var shadow_decal = shadow_decal_scene.instantiate()
	add_child(shadow_decal)
	shadow_decal.global_transform.origin = Vector3(0, 0, 0)

func _physics_process(delta: float) -> void:
	# Aplicar gravedad.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Manejar salto.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
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

	
	if velocity.x < 0:
		animation_player.play("Walk_animation")
		animation_player.scale = Vector3(-0.16, 0.16, 0.16)
		
	elif velocity.x > 0:
		animation_player.play("Walk_animation")
		animation_player.scale = Vector3(0.16, 0.16, 0.16)
		
	elif velocity.z != 0:
		animation_player.play("Walk_animation")
		
	elif Input.is_action_pressed("Ataque"):
		animation_player.play("attack")
		animation_player.scale = Vector3(-0.16, 0.16, 0.16) 
	
	else:
		animation_player.play("default")
		
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.is_in_group("door") and Input.is_action_pressed("Ataque"):
			emit_signal("attack_door", 10)
	
		
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
	
	
