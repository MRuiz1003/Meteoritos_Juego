class_name Canion
extends Node2D

export var proyectil = preload("res://Juego/Proyectiles/Proyectil.tscn")
export var cadencia_disparo: float = 0.8
export var velocidad_proyectil: int = 100
export var danio_proyectil: int = 1

onready var timer_enfriamiento: Timer = $TimerEnfriamiento
onready var disparo_sfx: AudioStreamPlayer2D = $DisparoSFX
onready var esta_enfriado: bool = true
onready var esta_disparando: bool = false setget set_esta_disparando

var puntos_disparo: Array = []

func set_esta_disparando(disparando: bool) -> void:
	esta_disparando = disparando
	
func _ready() -> void:
	almacenar_puntos_disparo()
	timer_enfriamiento.wait_time = cadencia_disparo
	
func _process(_delta: float) -> void:
	if esta_disparando and esta_enfriado:
		disparar()

func almacenar_puntos_disparo() -> void:
	for nodo in get_children():
		if nodo is Position2D:
			puntos_disparo.append(nodo)
		
func disparar() -> void:
	esta_enfriado = false
	timer_enfriamiento.start()
	for punto_disparo in puntos_disparo:
		var new_proyectil: Proyectil = proyectil.instance()
		new_proyectil.crear(
			punto_disparo.global_position,
			get_owner().rotation,
			velocidad_proyectil,
			danio_proyectil
			)
		disparo_sfx.play()
		Eventos.emit_signal("disparo", new_proyectil)

func _on_TimerEnfriamiento_timeout() -> void:
	esta_enfriado = true