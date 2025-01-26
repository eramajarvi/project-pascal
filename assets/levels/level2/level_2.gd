extends Node3D

@onready var text1 = $Text1/CuidadoConElVacio
@onready var text2 = $Text2/NoTodoEsLoQueParece
@onready var rightSpotligthLantern1 = $rightLanter1Platform/Area3D/SpotLight3D
@onready var leftSpotligthLantern2 = $leftLanter1Platform/Area3D/SpotLight3D
@onready var platformMoveSpotligth = $Stair3/platformMovementLantern/Area3D/SpotLight3D
@onready var middleLanternSpotligth = $middleLantern/Area3D/SpotLight3D

@export var entity_scene: PackedScene
var entidadesLiberadas: int = 0

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


func player_touched_bubble(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("jugador tocó burbuja")
		entidadesLiberadas += 1
		print("entidades liberadas: ", entidadesLiberadas)
		$HUDLabel.text = "entidades liberadas: " + str(entidadesLiberadas)
		


func _on_EntidadTimer_timeout() -> void:
	var entidad = $EntidadNode3D
	
	var entidadSpawnLocation = get_node("SpawnPath/SpawnLocation")
	entidadSpawnLocation.progress_ratio = randf()
	
	var spawn_position = entidadSpawnLocation.global_transform.origin
	
	#add_child(entidad)
	
	entidad.global_transform.origin = spawn_position
	entidad.gravity_scale = 0.6
	
	# Connect the 'body_entered' signal of the entity to a method in the current scene
	if entidad.has_signal("body_entered"):
		pass
		#print("entidad tiene la señal")
		#entidad.connect("body_entered", Callable(self, "_on_entidad_body_entered"))
	
	#entidad.connect("body_entered", Callable(self, "_on_entidad_body_entered"))
	
# Define the method to handle the signal
func _on_entidad_body_entered(body):
	emit_signal("body_entered", body)
	print("Body entered:", body.name)
	
	
	
