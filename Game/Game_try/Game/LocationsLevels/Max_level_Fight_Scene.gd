extends "res://Locations.gd"

func Fight_Scene():
	pass

func _ready():
	pass

func _on_Area_For_Falling_body_entered(body):
	if body.has_method("start_jump_heroe"):
		get_node("Heroe").queue_free()
	if body.has_method("enemy"):
		body.set_global_position(Vector2(946, -28))


