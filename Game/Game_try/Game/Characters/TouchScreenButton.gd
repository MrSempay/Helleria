extends TouchScreenButton


var jumping = false

var statusbar = preload("res://Game/Spells/BarDuration.tscn")

func _on_TouchScreenButton_released():
	jumping = false



func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		jumping = true
		#var statusbar1 = statusbar.instance()
		#get_parent().get_node("For_Status_Bars").add_child(statusbar1)
		#get_parent().get_node("For_Status_Bars/" + )for_position
		



func _on_Area2D_mouse_exited():
	#if !is_pressed():
		jumping = false
