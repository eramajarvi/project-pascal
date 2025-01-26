extends Area3D
@onready var lantern1 = $Sketchfab_Scene/AreaLantern1/lantern1/SpotLight3D
@onready var lantern2 = $Sketchfab_Scene/AreaLantern2/lantern2/SpotLight3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		lantern1.visible = true
		

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		lantern1.visible = false


func _on_area_lantern_2_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		lantern2.visible = true


func _on_area_lantern_2_body_exited(body: Node3D) -> void:
	if body.is_in_group('player'):
		lantern2.visible = false
