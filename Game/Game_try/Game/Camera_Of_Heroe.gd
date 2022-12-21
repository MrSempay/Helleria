extends Camera2D





func _ready():
	

	if get_parent().get_parent().has_method("Fight_Scene") or (get_parent().get_parent().has_method("First_Scene") && !GLOBAL.first_cat_scene):
		_set_current(true)
	
	if get_parent().get_parent().has_method("Temple_lvl") && GLOBAL.first_starting_temple_lvl == false:
		_set_current(true)
	
		
	if get_parent().get_parent().has_method("Temple_lvl") && get_parent().get_parent().has_node("Ghost"):
		_set_current(false)
