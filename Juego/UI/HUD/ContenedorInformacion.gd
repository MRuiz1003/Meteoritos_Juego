class_name ContenedorInformacion
extends NinePatchRect

export var auto_ocultar: bool = false setget set_auto_ocultar

onready var animaciones: AnimationPlayer = $AnimationPlayer
onready var texto_contenedor: Label = $Label
onready var auto_ocultar_timer: Timer = $AutoOcultarTimer

func set_auto_ocultar(ocultarlo: bool) -> void:
	auto_ocultar = ocultarlo
## Animaciones
func mostrar() -> void:
	animaciones.play("mostrar")

func ocultar() -> void:
	animaciones.play("ocultar")

func mostrar_suavizado() -> void:
	animaciones.play("mostrar_suavizado")
	if auto_ocultar:
		auto_ocultar_timer.start()
	
func ocultar_suavizado() -> void:
	animaciones.play("ocultar_suavizado")

## Metodos
func modificar_texto(text: String) -> void:
	texto_contenedor.text = text

## Señales
func _on_AutoOcultarTimer_timeout() -> void:
	ocultar_suavizado()
