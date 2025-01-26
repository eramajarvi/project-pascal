extends Node3D

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


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("jugador está en la plataforma")
	if body.is_in_group("player"):
		characters_on_platform.append(body)


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		characters_on_platform.erase(body)
