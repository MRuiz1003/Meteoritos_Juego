class_name BaseEnemiga
extends Node2D

export var hitpoints: float = 30.0
export var orbital: PackedScene  = null
export var numero_orbitales: int = 10
export var intervalo_spawn: float = 0.8


onready var impacto_sfx: AudioStreamPlayer2D = $ImpactoSFX
onready var ruta_enemigo: Path2D = $RutaEnemigo
onready var timer_spawner: Timer = $TimerSpawnerEnemigos

var esta_destruida: bool = false
var posicion_spawn: Vector2 = Vector2.ZERO

func _ready() -> void:
	timer_spawner.wait_time = intervalo_spawn
	$AnimationPlayer.play(elegir_animacion_aleatoria())
	
func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0 and not esta_destruida:
		esta_destruida = true
		destruir()
	impacto_sfx.play()
	
func destruir() -> void:
	var posicion_partes = [
		$Sprites/Sprite.global_position,
		$Sprites/Sprite2.global_position,
		$Sprites/Sprite3.global_position,
		$Sprites/Sprite4.global_position
	]
	Eventos.emit_signal("base_destruida", self, posicion_partes)
	queue_free()
	
func elegir_animacion_aleatoria() -> String:
	randomize()
	var num_anim: int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria: int = randi() % num_anim + 1
	var lista_animacion: Array = $AnimationPlayer.get_animation_list()
	
	return lista_animacion[indice_anim_aleatoria]
	
func spawnear_orbital() -> void:
	numero_orbitales -= 1
	ruta_enemigo.global_position = global_position
	var new_orbital: EnemigoOrbital = orbital.instance()
	new_orbital.crear(
		global_position + posicion_spawn,
		self,
		ruta_enemigo
	)
	Eventos.emit_signal("spawn_orbital", new_orbital)
	
func deteccion_cuadrante() -> Vector2:
	var player_objetivo: Player  = DatosJuego.get_player_actual()
	
	if not player_objetivo:
		return Vector2.ZERO
	
	var dir_player: Vector2 = player_objetivo.global_position - global_position
	var angulo_player: float = rad2deg(dir_player.angle())
	
	if abs(angulo_player) <= 45.0:
		ruta_enemigo.rotation_degrees = 180.0
		return $PosicionesSpawn/Este.position
	elif abs(angulo_player) > 135.0 and abs(angulo_player) <= 180.0: 
		ruta_enemigo.rotation_degrees = 0.0
		return $PosicionesSpawn/Oeste.position
	elif abs(angulo_player) > 45.0 and abs(angulo_player) <= 135.0:
		if sign(angulo_player) > 0:
			ruta_enemigo.rotation_degrees = 270.0
			return $PosicionesSpawn/Sur.position
		else:
			ruta_enemigo.rotation_degrees = 90.0
			return $PosicionesSpawn/Norte.position
	return $PosicionesSpawn/Norte.position
	
func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()


func _on_VisibilityNotifier2D_screen_entered() -> void:
	$VisibilityNotifier2D.queue_free()
	posicion_spawn = deteccion_cuadrante()
	spawnear_orbital()
	timer_spawner.start()


func _on_TimerSpawnerEnemigos_timeout() -> void:
	if numero_orbitales == 0:
		timer_spawner.stop()
		return
	spawnear_orbital()