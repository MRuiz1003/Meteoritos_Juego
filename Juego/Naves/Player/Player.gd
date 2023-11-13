class_name Player
extends RigidBody2D

export var potencia_motor: int = 20
export var potencia_rotacion: int = 280
export var estela_maxima: int = 150

var empuje: Vector2 = Vector2.ZERO
var dir_rotacion: int = 0

onready var canion:Canion = $Canion 
onready var laser:RayoLaser = $LaserBeam2D
onready var estela: Estela = $EstelaPuntoInicio/Trail2D
onready var motor_sfx: Motor = $MotorSFX

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)
	
func _process(_delta: float) -> void:
	player_input()
	
func _unhandled_input(event: InputEvent) -> void:
	#Disparo Rayo
	if event.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)
	if event.is_action_released("disparo_secundario"):
		laser.set_is_casting(false)

func player_input() -> void:
	## Empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0) 
	
	## Rotacion
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_horario"):
		dir_rotacion += 1
	elif Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1
		
	## Disparo
	if Input.is_action_pressed("disparo_principal"):
		canion.set_esta_disparando(true)
	if Input.is_action_just_released("disparo_principal"):
		canion.set_esta_disparando(false)
	
	# Control Estela y Sonido de Motor
	if Input.is_action_pressed("mover_adelante"):
		estela.set_max_points(estela_maxima)
		motor_sfx.sonido_on()
	elif Input.is_action_pressed("mover_atras"):
		estela.set_max_points(0)
		motor_sfx.sonido_on()
		
	if (Input.is_action_just_released("mover_adelante") or Input.is_action_just_released("mover_atras")):
		motor_sfx.sonido_off()
