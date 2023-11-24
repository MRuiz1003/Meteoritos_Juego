extends Node

func _ready() -> void:
	MusicaJuego.play_musica(MusicaJuego.get_lista_musicas().menu_principal)

func _on_BotonJugar_pressed() -> void:
	MusicaJuego.play_boton()
	get_tree().change_scene("res://Juego/Niveles/NivelTest.tscn")
	yield(get_tree().create_timer(1),"timeout")
