extends Node3D

const GRAVITY = 9.8
var velocity = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# add the gravity
	velocity.y -= GRAVITY * delta
	
	# Move the node in the global space
	global_transform.origin += velocity * delta


func _on_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
