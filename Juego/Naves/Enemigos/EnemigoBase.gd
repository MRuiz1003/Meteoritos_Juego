class_name EnemigoBase
extends NaveBase

func _ready() -> void:
	canion.set_esta_disparando(true)
	$AnimationPlayer.play("spawn")
	
func _on_body_entered(body: Node) -> void:
	._on_body_entered(body)
	if body is Player:
		body.destruir()
		destruir()