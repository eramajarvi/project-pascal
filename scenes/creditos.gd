extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("jugador toca salida")
		call_deferred("exit_to_main_menu")
		
		
func exit_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
