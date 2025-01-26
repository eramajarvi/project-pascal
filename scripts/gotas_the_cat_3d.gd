extends CharacterBody3D

const SPEED = 3.0
const JUMP_VELOCITY = 5.5

const RAY_LENGTH = 1000
signal attack_door(target)
signal touch_entity(target2)

@onready var audiomichi = $AudioAtaque
@onready var audioSalto = $AudioAtaque/AudioSalto
@onready var audiPasos = $AudioAtaque/AudioPasos
@onready var animation_player =  $AnimatedSprite3D
@onready var raycast: RayCast3D = $RayCast3D
@export var shadow_scene: PackedScene
var shadow_instance: Node3D


var health: int = 5 # Vida inicial del personaje
var BubbleShader = load("res://scripts/shaders/bubbleGraphics.gdshader") as Shader

func _ready() -> void:
	print("there is shadow instance from _ready")
	shadow_instance = shadow_scene.instantiate()
	add_child(shadow_instance)
		
	# Adjust its position and scaling relative to the player
	shadow_instance.position = Vector3(0, -1, 0)  # Position slightly below the player
	shadow_instance.scale = Vector3(2.5, 2.5, 2.5)  # Adjust scale if necessary
		
func _process(delta: float) -> void:
	shadow_instance.global_transform.origin = Vector3(global_transform.origin.x, global_transform.origin.y, global_transform.origin.z)
	
	

func _physics_process(delta: float) -> void:
	# Aplicar gravedad.
	if not is_on_floor():
		velocity += get_gravity() * delta
		shadow_instance.global_transform.origin = Vector3(global_transform.origin.x, global_transform.origin.y + JUMP_VELOCITY , global_transform.origin.z)

	# Manejar salto.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if not audioSalto.playing:
			audioSalto.play()
		
		
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
	
	if velocity.x or velocity.z != 0:
		if not audiPasos.playing:
			audiPasos.play()
	else:
		if audiPasos.playing:
			audiPasos.stop()


	
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
		audiomichi.play(0.0)
		animation_player.scale = Vector3(-0.16, 0.16, 0.16) 
	
	else:
		animation_player.play("default")
		
		
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider and collider.is_in_group("door") and Input.is_action_pressed("Ataque"):
			emit_signal("attack_door", 10)
			
		if collider and collider.is_in_group("entidad"):
			emit_signal("touch_entity", 1)
	
		
func take_damage(amount: int) -> void:
	var escenaActual = get_tree().current_scene
	print("el jugador perdió salud en: ", escenaActual)
	
	GameoverRespawner.setSpawnScene(escenaActual)
	
	var shader_material = ShaderMaterial.new()
	shader_material.shader = BubbleShader
	
	health -= amount
	
	if health == 4:
		$VidaBurbuja5.material = shader_material
		
	elif health == 3:
		$VidaBurbuja4.material = shader_material
		
	elif health == 2:
		$VidaBurbuja3.material = shader_material
		
	elif health == 1:
		$VidaBurbuja2.material = shader_material
	
	if health <= 0:
		die()

func die() -> void:
	var escenaActual = get_tree().current_scene
	
	print("el jugador murió en: ", escenaActual)
	GameoverRespawner.setSpawnScene(escenaActual)
	GameoverRespawner.precallGameOver()

func _onDamageDropColission(body: Node3D) -> void:
	if body.is_in_group("damage_drop"):
		print("drop entered")
		take_damage(1)
