extends Area3D

@export var text_to_display: String = "sabía que algo malo estaba pasado."
@onready var label4 = $Label3DTexto4

func _ready():
	label4.visible = false
	
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("body entered")
		label4.visible = true
		label4.text = text_to_display
