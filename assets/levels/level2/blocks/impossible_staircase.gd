extends Node3D

@onready var animation = %PenroseStairs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		print('EL PERSONAJE ENTRO EN LA ESCALERA DE PENROSE!')
		await get_tree().create_timer(1.0).timeout
		animation.play('move')
