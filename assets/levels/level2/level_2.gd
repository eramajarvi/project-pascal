extends Node3D

@onready var text1 = $Text1/CuidadoConElVacio
@onready var text2 = $Text2/NoTodoEsLoQueParece
@onready var rightSpotligthLantern1 = $rightLanter1Platform/Area3D/SpotLight3D
@onready var leftSpotligthLantern2 = $leftLanter1Platform/Area3D/SpotLight3D
@onready var platformMoveSpotligth = $Stair3/platformMovementLantern/Area3D/SpotLight3D
@onready var middleLanternSpotligth = $middleLantern/Area3D/SpotLight3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_1_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		text1.visible = true
		text1.text = '¡cuidado con tu vacío!'


func _on_text_1_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		text1.visible = false


func _on_text_2_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		text2.visible = true
		text2.text = 'No todo es lo que parece'


func _on_text_2_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		text2.visible = false

# When the player hits the lamps
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		rightSpotligthLantern1.visible = true
		leftSpotligthLantern2.visible = true
		#middleLanternSpotligth.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		rightSpotligthLantern1.visible = false
		leftSpotligthLantern2.visible = false
		#middleLanternSpotligth.visible = false
