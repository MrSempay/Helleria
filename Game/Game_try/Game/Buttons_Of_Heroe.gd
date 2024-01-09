extends Sprite




func _physics_process(delta):
	#pass
	if !get_parent().get_node("Camera_Of_Heroe").is_current() or !get_parent().get_parent().has_method("Fight_Scene"):
		set_visible(false)
