extends Node3D

var DoorBlockerHealth = 100

@onready var text1 = $Textos/Text1/SoloUnosPocos
@onready var text2 = $Textos/Text2/EncuentranElCamino
@onready var text3 = $Textos/Text3/OtrosNoQuieren

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TimeTracker.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Hacer que la cámara coincida con la posición del personaje
	var player_position = $GotasTheCat3D.position
	#print("player: ",  player_position)
	
	var camera_position = $GotasTheCat3D/CameraController.position
	
	camera_position.x = lerp_angle(camera_position.x, atan2(player_position.y, player_position.z), 0.15)
	camera_position.y = lerp_angle(camera_position.y, atan2(player_position.z, player_position.x), 0.1)

	$GotasTheCat3D/CameraController.position = camera_position


func _on_text_1_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		text1.visible = true
		text1.text = "solo unos pocos encuentran el camino"


func _on_text_2_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		text2.visible = true
		text2.text = "algunos no lo reconocen cuando lo tienen enfrente"


func _on_text_3_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		text3.visible = true
		text3.text = "otros no lo quieren reconocer"


func _on_FinalWormHole_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		call_deferred("changeToPreviousSceneToLevel2")
		
func changeToPreviousSceneToLevel2():
	get_tree().change_scene_to_file("res://assets/Secuencias/GatoElectrico/AntesNivel2.tscn")
