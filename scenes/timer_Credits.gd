extends Node2D

# Referencias a nodos
@onready var timer: Timer = $Timer
@onready var static_body: StaticBody2D = $"."
func _ready():
	# Inicia el temporizador
	timer.start()
	# Conectar señal del temporizador
	timer.timeout.connect(_on_Timer_timeout)

func _on_Timer_timeout():
	# Hace que el StaticBody2D desaparezca
	static_body.visible = false
	# Si quieres eliminarlo del árbol:
	static_body.queue_free()
