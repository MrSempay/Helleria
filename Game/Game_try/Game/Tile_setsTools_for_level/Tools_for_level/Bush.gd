extends Area2D

var mouse_in_area
var already_in_bush = false



func _ready():
	pass 




func _on_Bush_body_entered(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(true)

func _on_Bush_body_exited(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(false)

func _on_Area2D_mouse_entered():
	mouse_in_area = true


func _on_Area2D_mouse_exited():
	mouse_in_area = false

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed() && mouse_in_area:
		if !already_in_bush:
			get_parent().get_node("Heroe").set_z_index(0)
			get_parent().get_node("Heroe").in_invisibility = true
			already_in_bush = true
		else:
			get_parent().get_node("Heroe").set_z_index(3)
			get_parent().get_node("Heroe").in_invisibility = false
			already_in_bush = false
		
