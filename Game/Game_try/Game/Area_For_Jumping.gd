extends Area2D




func _physics_process(delta):
		#pass
		if !get_parent().get_parent().get_node("Camera_Of_Heroe").is_current():
			$CollisionShape2D.set_disabled(true)
			get_parent().get_node("TouchScreenButton").set_visible(false)
		else:
			$CollisionShape2D.set_disabled(false)
			get_parent().get_node("TouchScreenButton").set_visible(true)
