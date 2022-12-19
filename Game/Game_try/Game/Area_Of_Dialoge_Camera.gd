extends Area2D


var mouse_in_area
var input_touch = 0
var was_pressed_1 = false
var was_pressed_2 = false
var was_pressed_3 = false
var was_pressed_4 = false


func _physics_process(delta):
	pass
	
	if GLOBAL.aglea_dialoge_started && !GLOBAL.aglea_dialoge_finished or GLOBAL.heroe_dialoge_started && !GLOBAL.heroe_dialoge_finished:
		$CollisionShape2D.set_disabled(false)
	else:
		$CollisionShape2D.set_disabled(true)



func _input(event):
	if event is InputEventScreenTouch and event.is_pressed() && mouse_in_area:
		input_touch += 1
		was_pressed_1 = true
		was_pressed_2 = true
		was_pressed_3 = true
		was_pressed_4 = true


func _on_Area_Of_Dialoge_Camera_mouse_entered():
	mouse_in_area = true


func _on_Area_Of_Dialoge_Camera_mouse_exited():
	mouse_in_area = false
