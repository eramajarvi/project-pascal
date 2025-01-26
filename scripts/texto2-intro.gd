extends Area3D

@export var text_to_display: String = "sin pedirlo ni desearlo..."
@onready var label2 = $Label3DTexto2

func _ready():
	label2.visible = false
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("body entered")
		label2.visible = true
		label2.text = text_to_display
