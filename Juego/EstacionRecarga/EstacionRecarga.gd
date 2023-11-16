class_name EstacionRecarga
extends Node2D



func _on_AreaColision_body_entered(body: Node) -> void:
	if body.has_method("destruir"):
		body.destruir()
		

func _on_AreaRecarga_body_entered(body: Node) -> void:
	body.set_gravity_scale(0.1)
	
func _on_AreaRecarga_body_exited(body: Node) -> void:
	body.set_gravity_scale(0.0)




