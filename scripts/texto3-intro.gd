extends Area3D

@export var text_to_display: String = "aunque nunca supe mi rumbo..."
@onready var label3 = $Label3DTexto3

func _ready():
	label3.visible = false
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("body entered")
		label3.visible = true
		label3.text = text_to_display
