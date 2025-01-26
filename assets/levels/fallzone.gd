extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_ground_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		#print("jugador cayó")
		
		body.take_damage(1)
		
		respawn_player(body)

func respawn_player(player: Node3D) -> void:
	
	var CurrentScene = GameoverRespawner.getSpawnScene()
	
	if CurrentScene == "mainlevelselector":
		var respawn_position = Vector3(2.6, 8.1, 3.2)
		player.global_position = respawn_position
		
	elif CurrentScene == "level1":
		var respawn_position = Vector3(-44.38, 2.0, -9.6)
		player.global_position = respawn_position
	
	
