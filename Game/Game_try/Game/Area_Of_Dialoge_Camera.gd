extends Area2D


var mouse_in_area
var input_touch = 0
var was_pressed = false


func _physics_process(delta):
	if GLOBAL.aglea_dialoge_started:
		$CollisionShape2D.set_disabled(false)
	else:
		$CollisionShape2D.set_disabled(true)



func _input(event):
	if event is InputEventScreenTouch and event.is_pressed() && mouse_in_area:
		input_touch += 1
		was_pressed = true


func _on_Area_Of_Dialoge_Camera_mouse_entered():
	mouse_in_area = true


func _on_Area_Of_Dialoge_Camera_mouse_exited():
	mouse_in_area = false
