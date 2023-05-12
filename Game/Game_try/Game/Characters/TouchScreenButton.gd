extends TouchScreenButton


var jumping = false


func _on_TouchScreenButton_released():
	jumping = false



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		jumping = true
		



func _on_Area2D_mouse_exited():
	if !is_pressed():
		jumping = false
