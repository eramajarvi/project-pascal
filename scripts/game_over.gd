extends Node2D

@onready var retry_button = $HBoxContainer/RetryButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	retry_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	var PreviousScene = GameoverRespawner.getSpawnScene()
	get_tree().change_scene_to_file("res://scenes/levels/" + PreviousScene + ".tscn")
	

func _on_exit_button_pressed() -> void:
	get_tree().quit()
