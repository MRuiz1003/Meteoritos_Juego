class_name Nivel
extends Node2D

export var explosion: PackedScene = null
export var meteorito: PackedScene = preload("res://Juego/Meteoritos/Meteorito.tscn")
export var explosion_meteorito: PackedScene = preload("res://Juego/Explosiones/ExplosionMeteorito.tscn")
export var sector_meteoritos: PackedScene = preload("res://Juego/Meteoritos/SectorMeteoritos.tscn")

onready var contenedor_proyectiles: Node
onready var contenedor_meteoritos: Node
onready var contenedor_sector_meteoritos: Node

func _ready() -> void:
	conectar_seniales()
	crear_contenedores()
	
func conectar_seniales() -> void:
# warning-ignore:return_value_discarded
	Eventos.connect("disparo", self, "_on_disparo")
# warning-ignore:return_value_discarded
	Eventos.connect("nave_destruida", self, "_on_nave_destruida")
# warning-ignore:return_value_discarded
	Eventos.connect("spawn_meteorito", self, "_on_spawn_meteoritos")
# warning-ignore:return_value_discarded
	Eventos.connect("meteorito_destruido", self, "_on_meteorito_destruido")
# warning-ignore:return_value_discarded
	Eventos.connect("nave_en_sector_peligro", self, "_on_nave_en_sector_peligro")
	
func crear_contenedores() -> void:
	## Disparos
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
	## Meteoritos
	contenedor_meteoritos = Node.new()
	contenedor_meteoritos.name = "ContenedorMeteoritos"
	add_child(contenedor_meteoritos)
	
	## Sector Meteoritos
	contenedor_sector_meteoritos = Node.new()
	contenedor_sector_meteoritos.name = "ContenedorSectorMeteoritos"
	add_child(contenedor_sector_meteoritos)
	
func crear_sector_meteoritos(centro_camara: Vector2, numero_peligros: int) -> void:
	var new_sector_meteoritos: SectorMeteoritos = sector_meteoritos.instance()
	new_sector_meteoritos.crear(centro_camara, numero_peligros)
	contenedor_sector_meteoritos.add_child(new_sector_meteoritos)
	
func _on_spawn_meteoritos( pos_spawn: Vector2, dir_meteorito: Vector2, tamanio: float ) -> void:
	var new_meteorito: Meteorito = meteorito.instance()
	new_meteorito.crear(
		pos_spawn,
		dir_meteorito,
		tamanio
	)
	contenedor_meteoritos.add_child(new_meteorito)

func _on_disparo(proyectil: Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)
	
func _on_nave_destruida(posicion: Vector2, num_explosiones: int) -> void:
	for _i in range(num_explosiones):
		var new_explosion: Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6), "timeout")
		
func _on_meteorito_destruido(pos: Vector2) -> void:
	var new_explosion: ExplosionMeteorito = explosion_meteorito.instance()
	new_explosion.global_position = pos
	add_child(new_explosion)
		
func _on_nave_en_sector_peligro(centro_cam: Vector2, tipo_peligro: String, num_peligros: int) -> void:
	if tipo_peligro == "Meteorito":
		crear_sector_meteoritos(centro_cam, num_peligros)
	elif tipo_peligro == "Enemigo":
		pass

