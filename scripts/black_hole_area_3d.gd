extends Area3D

var audio_player: AudioStreamPlayer

func _ready():
	# Get the AudioStreamPlayer node.
	audio_player = %Audio02GhostsI

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("change_scene_to_post_intro")

func change_scene_to_post_intro() -> void:
	audio_player.get_parent().remove_child(audio_player)
	# get_tree().change_scene_to_file("res://scenes/post_intro.tscn")
	
	var PostIntroScene = ResourceLoader.load("res://scenes/post_intro.tscn").instantiate()
	
	get_tree().current_scene.free()
	get_tree().root.add_child(PostIntroScene)
	get_tree().current_scene = PostIntroScene
	
	PostIntroScene.add_child(audio_player)
	audio_player.set_owner(PostIntroScene)
	
	
