extends Sprite



func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			z_index = 5
			##(event.is_pressed())
		else:
			z_index = -15
			

