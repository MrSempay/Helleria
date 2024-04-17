extends KinematicBody2D




func _ready():
	z_index = -15
	
"""
var move = load("res://TouchScreenButton.gd")
var move1 = move.new()
onready var joystick = get_parent().get_node("Joystick/TouchScreenButton")

func _process(delta):
	move_and_slide(joystick.get_value() * 100)
	if move1._input() == true:
		z_index = 5
"""	
func inputt(event):
		z_index = 5
		if event is InputEventScreenTouch and event.is_pressed():
	#if event is InputEventMouseButton:
	#	if event.is_pressed():
			z_index = 5
			return z_index
			#(event.is_pressed())
		else:
			z_index = -15
			return z_index
