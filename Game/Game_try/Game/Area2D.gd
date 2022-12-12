extends Area2D


var input_touch = 0
var was_pressed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		input_touch += 1
		was_pressed = true
