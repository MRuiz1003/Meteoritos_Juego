extends Control

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_BotonSalir_pressed() -> void:
	get_tree().quit()

func _on_BotonMenu_pressed() -> void:
	get_tree().change_scene("res://Juego/UI/Menus/MenuPrincipal.tscn")

func _on_BotonContinuar_pressed() -> void:
	get_tree().paused = not get_tree().paused
	visible = not visible
