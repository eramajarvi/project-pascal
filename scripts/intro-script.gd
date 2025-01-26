extends Node

func _ready():
	AudioPlayerIntroLevels.play_music_level()
	
func _physics_process(delta: float) -> void:
	# Hacer que la cámara coincida con la posición del personaje
	var position = $GotasTheCat3D.position
	var camera_position = $GotasTheCat3D/CameraController.position
	
	camera_position.x = lerp(camera_position.x, position.x, 0.08)
	camera_position.y = lerp(camera_position.y, position.y, 0.08)
	$GotasTheCat3D/CameraController.position = camera_position

func _on_black_hole_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene_to_post_intro")
		
func change_scene_to_post_intro() -> void:
	get_tree().change_scene_to_file("res://scenes/post_intro.tscn")
	
