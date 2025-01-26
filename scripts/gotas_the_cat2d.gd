extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -300.0

@onready var audiomichi = $AudioAtaque
@onready var audioSalto = $AudioAtaque/AudioSalto
@onready var audiPasos = $AudioAtaque/AudioPasos
@onready var animation_player =  $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if not audioSalto.playing:
			audioSalto.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x < 0:
		animation_player.play("Walk_animation")
		animation_player.scale = Vector2(-0.3, 0.3)
	elif velocity.x > 0:
		animation_player.play("Walk_animation")
		animation_player.scale = Vector2(0.3, 0.3)
	else:
	# Anidar otro if dentro del else
		if velocity.y != 0:
			animation_player.play("Walk_animation")  # Reproduce otra animación si Z tiene movimiento
		else:
			animation_player.play("default")  # Caso por defecto cuando X y Z son cero

	move_and_slide()
	
	if velocity.x != 0:
		if not audiPasos.playing:
			audiPasos.play()
	else:
		if audiPasos.playing:
			audiPasos.stop()
