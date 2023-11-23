extends Node

# warning-ignore:unused_signal
signal disparo(proyectil)
# warning-ignore:unused_signal
signal nave_destruida(nave, posicion, explosiones)
# warning-ignore:unused_signal
signal spawn_meteorito(posicion, direccion, tamanio)
# warning-ignore:unused_signal
signal meteorito_destruido(posicion)
# warning-ignore:unused_signal
signal nave_en_sector_peligro(centro_camara, tipo_peligro, num_peligros)
signal base_destruida(base ,posiciones)
signal spawn_orbital(orbital)

## HUD
signal nivel_iniciado()
signal nivel_terminado()
signal detecto_zona_recarga(entrando)
signal cambio_numero_meteoritos(numero)
signal actualizar_tiempo(tiempo_restante)
signal cambio_energia_laser(energia_max, energia_actual)
signal ocultar_energia_laser()
signal cambio_energia_escudo(energia_max, energia_actual)
signal ocultar_energia_escudo()
signal minimapa_objeto_creado()
signal minimapa_objeto_eliminado(objeto)
