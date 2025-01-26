extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Hacer que la cámara coincida con la posición del personaje
	var player_position = $GotasTheCat3D.position
	#print("player: ",  player_position)
	
	var camera_position = $GotasTheCat3D/CameraController.position
	
	camera_position.x = lerp_angle(camera_position.x, atan2(player_position.y, player_position.z), 0.15)
	camera_position.y = lerp_angle(camera_position.y, atan2(player_position.z, player_position.x), 0.1)

	$GotasTheCat3D/CameraController.position = camera_position



func _level1_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene_to_level1")
		

func change_scene_to_level1() -> void:
	get_tree().change_scene_to_file("res://assets/Secuencias/GatoQuemandose/AntesNivel1.tscn")


func _level2_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene_to_level2")
		
func change_scene_to_level2() -> void:
	get_tree().change_scene_to_file("res://assets/levels/level2/level2.tscn")
