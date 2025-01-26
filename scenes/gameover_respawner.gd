extends Node

var sceneWherePlayerDied = ""

@onready var GameOverScene = preload("res://scenes/game_over.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setSpawnScene(currentScene) -> void:
	sceneWherePlayerDied = currentScene.name
	
func getSpawnScene() -> String:
	if sceneWherePlayerDied != "":
		var scene_path = str(sceneWherePlayerDied)  # Convert StringName to String
		
		#print("from getSpawnScene: ", scene_path)
		return scene_path.to_lower()
		
	else:
		#print("No spawn scene stored.")
		return ""
		
func precallGameOver() -> void:
	call_deferred("show_gameover_scene")

func show_gameover_scene() -> void:
	get_tree().change_scene_to_packed(GameOverScene)
	print("dentro de show_gameover, la escena de respawn es: ", sceneWherePlayerDied)
	
func respawnPlayerInPreviousScene() -> void:
	print("player is trying to respawn in: ", sceneWherePlayerDied)
	get_tree().change_scene_to_packed(GameoverRespawner.sceneWherePlayerDied)
