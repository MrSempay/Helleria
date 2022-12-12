extends Area2D


var input_touch = 0
var was_pressed = false


func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		input_touch += 1
		was_pressed = true
