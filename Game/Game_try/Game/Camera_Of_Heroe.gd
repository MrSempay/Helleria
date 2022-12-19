extends Camera2D





func _ready():
	if get_parent().get_parent().has_method("Fight_Scene") or (get_parent().get_parent().has_method("First_Scene") && !GLOBAL.first_cat_scene):
		_set_current(true)
	#set_offset(Vector2(500,500))
