extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	await get_tree().create_timer(5.0).timeout
	call_deferred("loadLevel2")
	
func loadLevel2(): 
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")
