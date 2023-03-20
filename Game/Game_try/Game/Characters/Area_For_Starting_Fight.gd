extends Area2D



func area_for_fight():
	pass



func _ready():
	if get_parent().get_parent().has_method("Fight_Scene"):
		self.set_monitoring(false)
	else:
		self.set_monitoring(true)


