extends StaticBody2D





func _physics_process(delta):
	if get_parent().get_parent().has_node("Heroe"):
		if get_node("../../Heroe").global_position.y > self.global_position.y && get_node("../../Heroe").global_position.x < self.global_position.x:
			$CollisionShape2D.set_disabled(true)
		else:
			$CollisionShape2D.set_disabled(false)
