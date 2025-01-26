extends Node3D

var DoorBlockerHealth = 100

@onready var text1 = $Text1/SoloUnosPocos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Hacer que la cámara coincida con la posición del personaje
	var player_position = $GotasTheCat3D.position
	#print("player: ",  player_position)
	
	var camera_position = $GotasTheCat3D/CameraController.position
	
	camera_position.x = lerp_angle(camera_position.x, atan2(player_position.y, player_position.z), 0.15)
	camera_position.y = lerp_angle(camera_position.y, atan2(player_position.z, player_position.x), 0.1)

	$GotasTheCat3D/CameraController.position = camera_position
