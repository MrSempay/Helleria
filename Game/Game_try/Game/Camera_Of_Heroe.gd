extends Camera2D





func _ready():
	if get_parent().get_parent().has_method("Fight_Scene"):
		_set_current(true)
	#set_offset(Vector2(500,500))
