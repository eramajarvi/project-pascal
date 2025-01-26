extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene_to_main_world")
		
func change_scene_to_main_world() -> void:
	AudioPlayerIntroLevels.stop_music()
	get_tree().change_scene_to_file("res://scenes/levels/mainlevelselector.tscn")
	
