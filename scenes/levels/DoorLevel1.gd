extends StaticBody3D

@export var max_health: int = 1000
var current_health: int = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		destroy()
	else:
		update_damage_effect()
		
func destroy():
	# Optional: Gradual destruction effect
	queue_free()
	
func update_damage_effect():
	# Update door appearance based on health
	var alpha = float(current_health) / max_health
	#$MeshInstance3D.material_override.albedo_color.a = alpha
