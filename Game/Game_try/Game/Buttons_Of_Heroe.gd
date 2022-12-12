extends Sprite




func _physics_process(delta):
	if !get_parent().get_node("Camera_Of_Heroe").is_current():
		set_visible(false)
