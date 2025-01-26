extends StaticBody3D

@export var max_health: int = 2000
var current_health: int = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		destroy()
	else:
		update_damage_effect()
		
func destroy():
	# Optional: Gradual destruction effect
	queue_free()
	
func update_damage_effect():
	print("current health: ", current_health)
	
	if current_health >= 0.9 * max_health:
		$DoorSprite.transparency = 0.1
		
	elif (current_health >= 0.8 * max_health):
		$DoorSprite.transparency = 0.2
		
	elif (current_health >= 0.7 * max_health):
		$DoorSprite.transparency = 0.3
		
	elif (current_health >= 0.6 * current_health):
		$DoorSprite.transparency = 0.4
		
	elif (current_health >= 0.5 * current_health):
		$DoorSprite.transparency = 0.5
		
	elif (current_health >= 0.4 * current_health):
		$DoorSprite.transparency = 0.6
		
	elif (current_health >= 0.3 * current_health):
		$DoorSprite.transparency = 0.75
		
	elif (current_health >= 0.2 * current_health):
		$DoorSprite.transparency = 0.85
		
	elif (current_health >= 0.1 * current_health):
		$DoorSprite.transparency = 0.95
