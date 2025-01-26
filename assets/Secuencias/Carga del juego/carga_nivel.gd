extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	await get_tree().create_timer(2.0).timeout
	call_deferred("loadLevelNext")
	
func loadLevelNext(): 
	print("a")
