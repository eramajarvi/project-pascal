extends Node3D

# Referencia al AnimationPlayer
@onready var animation_player = %stair3Animations
var characters_on_platform = []
var previous_position = Vector3.ZERO

func _ready():
	# Store the initial position
	previous_position = global_transform.origin

func _process(delta):
	# Calculate the platform's movement
	var current_position = global_transform.origin
	var movement_delta = current_position - previous_position

	# Move all characters standing on the platform
	for character in characters_on_platform:
		if character:
			character.global_transform.origin += movement_delta

	# Update the previous position for the next frame
	previous_position = current_position

func _on_area_3d_body_entered(body: Node) -> void:
	print("Cuerpo detectado en la ultima escalera: ", body.name)
	if body.is_in_group('player'):
		print("Personaje encima de la Tercera escalera")
		await get_tree().create_timer(1.0).timeout
		characters_on_platform.append(body)
		animation_player.play("fall")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		characters_on_platform.erase(body)
