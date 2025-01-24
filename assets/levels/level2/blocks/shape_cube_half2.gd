extends Node3D

# Referencia al AnimationPlayer
@onready var animation_player = %stair2Animations


func _on_area_3d_body_entered(body: Node) -> void:
	print("Cuerpo detectado: ", body.name)
	if body.is_in_group('player'):
		print("Personaje encima de la escalera")
		await get_tree().create_timer(1.0).timeout
		animation_player.play("fall")
