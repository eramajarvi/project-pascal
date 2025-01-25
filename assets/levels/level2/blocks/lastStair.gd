extends Node3D

@onready var animation_player = %lastStairAnimation
var previous_position = Vector3.ZERO
var characters_on_platform = []

# Store the initial position
func _ready():
	previous_position = global_transform.origin

func _process(delta):
	# Calculate the platform movement
	var current_position = global_transform.origin
	var movement_delta = current_position - previous_position
	
	# Move the character standing on the platform
	for character in characters_on_platform:
		if character:
			character.global_transform.origin += movement_delta
		
	# Updated the previous position
	previous_position = current_position	


func _on_area_3d_body_entered(body: Node) -> void:
	print("Cuerpo detectado: ", body.name)
	if body.is_in_group('player'):
		print("Personaje encima de la Ultima escalera")
		characters_on_platform.append(body)
		await get_tree().create_timer(1.0).timeout
		animation_player.play("shape")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		characters_on_platform.erase(body)
