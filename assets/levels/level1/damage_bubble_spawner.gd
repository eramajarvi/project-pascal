extends Node3D

@export var sphere_scene: PackedScene
@export var shadow_decal_scene: PackedScene  # Preload a Decal scene with the shadow texture
@export var plane_size_x: float = 20.0
@export var plane_size_z: float = 20.0
@export var spawn_height: float = 5.0
@export var spawn_interval: float = 1.0
@export var spheres_per_spawn: int = 5

# Reference to the instantiated Scene A (set in the editor or dynamically find it)
@export var VolcanoScenePath: NodePath

var spawn_timer: float = 1.0
var isPlayerInArea: bool = false

func _ready():
	spawn_timer = spawn_interval
	

func _process(delta):
	if isPlayerInArea:
		spawn_timer -= delta
		if spawn_timer <= 0.0:
			
			spawn_multiple_spheres()
			spawn_timer = spawn_interval

func spawn_multiple_spheres():
	for i in range(spheres_per_spawn):
		spawn_sphere()

func spawn_sphere():
	var VolcanoWithBubblenimation = %AnimationPlayer
	VolcanoWithBubblenimation.play("bubbleGoingUp")
	await VolcanoWithBubblenimation.animation_finished
	#await get_tree().create_timer(2.0).timeout
		
	if not sphere_scene or not shadow_decal_scene:
		return
	
	# Generate random position within the plane bounds
	var random_x = randf_range(-5.4, 5.5)
	var random_z = randf_range(-8.4, 5.4)
	var spawn_position = Vector3(random_x, spawn_height, random_z)
	
	# Instance the sphere
	var sphere = sphere_scene.instantiate()
		
	add_child(sphere)
	sphere.global_transform.origin = spawn_position
	
	# Instance the shadow decal
	var shadow_decal = shadow_decal_scene.instantiate()
	add_child(shadow_decal)
	shadow_decal.global_transform.origin = Vector3(random_x, 0, random_z)  # Projected onto the plane

	# Pair the sphere and shadow for updates
	sphere.set_meta("shadow_decal", shadow_decal)
	#sphere.connect("tree_exited", self, "_on_sphere_exited", [shadow_decal])
	#sphere.connect("process", self, "_update_shadow_position")

func _update_shadow_position(sphere: Node3D):
	# Get the shadow decal linked to this sphere
	if not sphere.has_meta("shadow_decal"):
		return
		
	var shadow_decal = sphere.get_meta("shadow_decal")
	
	# Update shadow position to stay aligned with the sphere
	var sphere_position = sphere.global_transform.origin
	shadow_decal.global_transform.origin = Vector3(sphere_position.x, 0, sphere_position.z)

func _on_sphere_exited(shadow_decal: Node3D):
	# Cleanup the shadow decal when the sphere is removed
	print("sphere_exited called")
	if is_instance_valid(shadow_decal):
		shadow_decal.queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("volcanoDamageGroup"):
		body.queue_free()
		

func _on_area_3d_player_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		isPlayerInArea = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		isPlayerInArea = false
