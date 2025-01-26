extends Sprite2D

# Variables configurables
@export var speed: float = 100.0 # Velocidad de subida
@export var screen_margin: float = 10.0 # Margen para reaparecer fuera de la pantalla

func _process(delta: float) -> void:
	# Elevar el sprite suavemente
	position.y -= speed * delta

	# Verificar si el sprite ha salido de la pantalla
	if position.y + texture.get_size().y < 0:
		reset_position()

func reset_position() -> void:
	# Reposicionar el sprite en la parte inferior de la pantalla
	position.y = get_viewport_rect().size.y + screen_margin
	position.x = randf_range(0.0, get_viewport_rect().size.x)
