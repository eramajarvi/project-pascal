extends Area3D

@export var text_to_display: String = "un día llegué a este mundo..."
@onready var label1 = $Label3DTexto1

func _ready():
	label1.visible = false
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("body entered")
		label1.visible = true
		label1.text = text_to_display
